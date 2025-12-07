#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Value.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Transforms/Utils/ValueMapper.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include <vector>
#include <unordered_map>
#include <set>

using namespace llvm;

namespace {

struct GreedyPrefetchPass : public PassInfoMixin<GreedyPrefetchPass> {

  // --- Helper: Check if a pointer is modified (Written to) ---
  // Traces the use-def chain to check if the pointer is used as the destination of a StoreInst.
  bool isPointerModified(Value *Ptr) {
    SmallVector<User *, 8> Worklist;
    SmallPtrSet<User *, 16> Visited;

    for (User *U : Ptr->users()) {
      Worklist.push_back(U);
    }

    while (!Worklist.empty()) {
      User *U = Worklist.pop_back_val();
      if (!Visited.insert(U).second) continue;

      // Check for Store Instruction
      if (auto *SI = dyn_cast<StoreInst>(U)) {
        // If we are storing INTO the pointer (it is the pointer operand)
        if (SI->getPointerOperand()->stripPointerCasts() == Ptr->stripPointerCasts()) {
            return true; 
        }
        // Be conservative: if it's used as the value operand, we continue searching
      }
      
      // Traverse through transparent instructions
      if (isa<GetElementPtrInst>(U) || isa<BitCastInst>(U) || isa<AddrSpaceCastInst>(U) || isa<PHINode>(U)) {
        for (User *NU : U->users()) {
          Worklist.push_back(NU);
        }
      }
    }
    return false;
  }

  // --- Helper: Trace Value back to Argument (Fixes Infinite Recursion) ---
  Argument* traceToArgument(Value *V, SmallPtrSetImpl<Value*> &Visited) {
    if (!V) return nullptr;
    
    // BREAK CYCLE: If we have visited this value, stop.
    if (!Visited.insert(V).second) return nullptr;

    V = V->stripPointerCasts();

    // 1. Direct match
    if (auto *Arg = dyn_cast<Argument>(V)) {
      return Arg;
    }

    // 2. GEP: Trace base pointer
    if (auto *GEP = dyn_cast<GetElementPtrInst>(V)) {
      return traceToArgument(GEP->getPointerOperand(), Visited);
    }

    // 3. PHI: Check all incoming values (Aggressive search)
    if (auto *PHI = dyn_cast<PHINode>(V)) {
      for (Value *Inc : PHI->incoming_values()) {
        if (auto *Res = traceToArgument(Inc, Visited)) return Res;
      }
    }
    
    // 4. Select
    if (auto *Sel = dyn_cast<SelectInst>(V)) {
        if (auto *Res = traceToArgument(Sel->getTrueValue(), Visited)) return Res;
        if (auto *Res = traceToArgument(Sel->getFalseValue(), Visited)) return Res;
    }

    // 5. Load -> Alloca -> Store (Legacy/O0 pattern)
    if (auto *LI = dyn_cast<LoadInst>(V)) {
        if (auto *AI = dyn_cast<AllocaInst>(LI->getPointerOperand()->stripPointerCasts())) {
            for (User *U : AI->users()) {
                if (auto *SI = dyn_cast<StoreInst>(U)) {
                    if (SI->getPointerOperand()->stripPointerCasts() == AI) {
                         if (auto *Res = traceToArgument(SI->getValueOperand(), Visited)) return Res;
                    }
                }
            }
        }
    }

    return nullptr;
  }

  // ==========================================================
  // Part 1: Recursive Function Prefetching (Hoisting)
  // ==========================================================

  struct PrefetchTarget {
    Argument *BaseArg;
    StructType *SourceType;
    std::vector<Value*> Indices;
    bool IsWrite;
  };

  std::vector<PrefetchTarget> identifyRecursionTargets(Function &F) {
    std::vector<PrefetchTarget> Targets;

    for (auto &BB : F) {
      for (auto &I : BB) {
        auto *CI = dyn_cast<CallInst>(&I);
        if (!CI) continue;

        Function *Callee = CI->getCalledFunction();
        if (Callee != &F) continue;

        for (unsigned i = 0; i < CI->arg_size(); ++i) {
          Value *OutgoingVal = CI->getArgOperand(i)->stripPointerCasts();
          auto *Load = dyn_cast<LoadInst>(OutgoingVal);
          if (!Load) continue;

          Value *LoadAddr = Load->getPointerOperand()->stripPointerCasts();
          auto *GEP = dyn_cast<GetElementPtrInst>(LoadAddr);
          if (!GEP) continue;

          bool AllConstant = true;
          for (auto &Idx : GEP->indices()) {
              if (!isa<Constant>(Idx)) {
                  AllConstant = false;
                  break;
              }
          }
          if (!AllConstant) continue;

          SmallPtrSet<Value*, 8> Visited;
          if (Argument *BaseArg = traceToArgument(GEP->getPointerOperand(), Visited)) {
             if (BaseArg->getParent() == &F) {
                StructType *ST = dyn_cast<StructType>(GEP->getSourceElementType());
                if (!ST) continue;

                bool IsWrite = isPointerModified(BaseArg);
                std::vector<Value*> Indices(GEP->idx_begin(), GEP->idx_end());
                Targets.push_back({BaseArg, ST, Indices, IsWrite});
             }
          }
        }
      }
    }
    return Targets;
  }

  void injectRecursivePrefetches(Function &F, const std::vector<PrefetchTarget> &Targets) {
    if (Targets.empty()) return;

    LLVMContext &Ctx = F.getContext();
    BasicBlock *EntryBB = &F.getEntryBlock();
    IRBuilder<> Builder(EntryBB->getFirstNonPHI());

    Type *PtrTy = PointerType::getUnqual(Ctx);
    Function *PrefetchFn = Intrinsic::getOrInsertDeclaration(
        F.getParent(), Intrinsic::prefetch, {PtrTy});

    for (const auto &Target : Targets) {
      Instruction *SplitPoint = &*Builder.GetInsertPoint();
      
      // Safety check: Arg != NULL
      Value *IsNonNull = Builder.CreateIsNotNull(Target.BaseArg, "rds.check");
      
      BasicBlock *ContBB = EntryBB->splitBasicBlock(SplitPoint, "rds.cont");
      BasicBlock *PrefetchBB = BasicBlock::Create(Ctx, "rds.prefetch", &F, ContBB);
      
      EntryBB->getTerminator()->eraseFromParent();
      IRBuilder<> EntryBuilder(EntryBB);
      EntryBuilder.CreateCondBr(IsNonNull, PrefetchBB, ContBB);
      
      IRBuilder<> PrefetchBuilder(PrefetchBB);
      
      // Reconstruct GEP and Load
      Value *ElementAddr = PrefetchBuilder.CreateInBoundsGEP(
          Target.SourceType, Target.BaseArg, Target.Indices, "rds.gep");
      
      // Load the child pointer (Greedy approach)
      Value *ChildPtr = PrefetchBuilder.CreateLoad(PtrTy, ElementAddr, "rds.load");
      
      // 1 = Write (exclusive), 0 = Read (shared)
      Value *RW = ConstantInt::get(Type::getInt32Ty(Ctx), Target.IsWrite ? 1 : 0);
      Value *Locality = ConstantInt::get(Type::getInt32Ty(Ctx), 3); // 3 = High Locality (L1/L2)
      Value *Temp = ConstantInt::get(Type::getInt32Ty(Ctx), 1);     // 1 = Data Cache

      PrefetchBuilder.CreateCall(PrefetchFn, {ChildPtr, RW, Locality, Temp});
      PrefetchBuilder.CreateBr(ContBB);
      
      // Move insertion point for next target
      Builder.SetInsertPoint(ContBB->getFirstNonPHI());
      EntryBB = ContBB;
    }
  }

  // ==========================================================
  // Part 2: Loop-based Prefetching (Look-ahead Cloning)
  // ==========================================================

  struct LoopPrefetchCandidate {
    Instruction *LoadInst;
    GetElementPtrInst *GepInst;
    Value *BasePtr;
    bool IsWrite;
  };

  std::vector<LoopPrefetchCandidate> findLoopCandidates(Loop *L) {
    std::vector<LoopPrefetchCandidate> Candidates;
    BasicBlock *Header = L->getHeader();

    for (auto &I : *Header) {
      auto *PHI = dyn_cast<PHINode>(&I);
      if (!PHI) continue;

      bool IsWrite = isPointerModified(PHI);

      for (unsigned i = 0; i < PHI->getNumIncomingValues(); ++i) {
        if (L->contains(PHI->getIncomingBlock(i))) {
           Value *Inc = PHI->getIncomingValue(i);
           if (auto *Load = dyn_cast<LoadInst>(Inc)) {
              if (auto *GEP = dyn_cast<GetElementPtrInst>(Load->getPointerOperand())) {
                 if (GEP->getPointerOperand() == PHI) {
                    Candidates.push_back({Load, GEP, PHI, IsWrite});
                 }
              }
           }
        }
      }
    }
    return Candidates;
  }

  void injectLoopPrefetch(const LoopPrefetchCandidate &Cand) {
    IRBuilder<> Builder(Cand.LoadInst->getNextNode());
    LLVMContext &Ctx = Cand.LoadInst->getContext();

    // NextPtr is the value loaded for the next iteration (e.g., node->next)
    Value *NextPtr = Cand.LoadInst; 

    Type *I8Ptr = PointerType::getUnqual(Ctx);
    Function *PrefetchFn = Intrinsic::getOrInsertDeclaration(
        Cand.LoadInst->getModule(), Intrinsic::prefetch, {I8Ptr});

    Value *RW = ConstantInt::get(Type::getInt32Ty(Ctx), Cand.IsWrite ? 1 : 0);
    Value *Locality = ConstantInt::get(Type::getInt32Ty(Ctx), 3);
    Value *Temp = ConstantInt::get(Type::getInt32Ty(Ctx), 1);

    // 1. Basic Greedy: Prefetch the node we just loaded
    Builder.CreateCall(PrefetchFn, {NextPtr, RW, Locality, Temp});

    // 2. Look-ahead (1 pointer ahead): Clone GEP to calculate address of Next->next
    // This helps hide latency better in tight loops.
    Instruction *ClonedGEP = Cand.GepInst->clone();
    ClonedGEP->setOperand(0, NextPtr); // Rebase GEP to start from NextPtr
    ClonedGEP->setName("prefetch.lookahead.gep");
    
    if (auto *InsertPt = dyn_cast<Instruction>(NextPtr)) {
        ClonedGEP->insertAfter(InsertPt);
    } else {
        ClonedGEP->insertBefore(Cand.LoadInst->getNextNode()); 
    }
    
    // We prefetch the *address* of the next field. 
    // This brings the cache line containing the 'next' pointer into cache.
    Builder.SetInsertPoint(ClonedGEP->getNextNode());
    Builder.CreateCall(PrefetchFn, {ClonedGEP, RW, Locality, Temp});
  }

  // ==========================================================
  // Main Run
  // ==========================================================

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    if (F.isDeclaration()) return PreservedAnalyses::all();

    bool Changed = false;

    // 1. Recursive Data Structure Prefetching
    std::vector<PrefetchTarget> RecTargets = identifyRecursionTargets(F);
    if (!RecTargets.empty()) {
        injectRecursivePrefetches(F, RecTargets);
        Changed = true;
    }

    // 2. Loop-based Prefetching
    LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
    for (auto *L : LI) {
      auto Candidates = findLoopCandidates(L);
      for (const auto &Cand : Candidates) {
        injectLoopPrefetch(Cand);
        Changed = true;
      }
    }

    return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
  }
};

} // end anonymous namespace

extern "C" ::llvm::PassPluginLibraryInfo
LLVM_ATTRIBUTE_WEAK llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "GreedyPrefetch", "v0.1",
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "greedy-prefetch") {
                    FPM.addPass(GreedyPrefetchPass());
                    return true;
                  }
                  return false;
                });
          }};
}