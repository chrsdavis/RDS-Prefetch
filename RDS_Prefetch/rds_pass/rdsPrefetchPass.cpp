/*
Implementation of greedy prefetching algorithm from:
"Compiler-Based Prefetching for Recursive Data Structures"
by Chi-Keung Luk and Todd C. Mowry (PLDI 1996)
This pass identifies recursive data structure (RDS) traversals
and inserts prefetch instructions for "natural jump pointers"
(pointers not immediately followed) to hide memory latency.
*/


#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

#include <set>
#include <map>
#include <vector>
#include <unordered_set>

using namespace llvm;

#define DEBUG_TYPE "rds-prefetch"

namespace {

// helper class to analyze and track RDS types
class RDSTypeAnalyzer {
private:
  std::set<StructType*> rdsTypes;
  std::set<StructType*> visiting; // for cycle detection
  
public:
  // check if a struct type is an RDS type (contains pointers to record types)
  bool isRDSStructType(StructType *structTy) {
    // already classified
    if (rdsTypes.count(structTy))
      return true;
    
    // avoid infinite recursion for self-referential structures
    if (visiting.count(structTy))
      return false;
    
    visiting.insert(structTy);
    
    // check if this struct contains at least one pointer to a record type
    bool hasPointerToRecord = false;
    for (Type *fieldTy : structTy->elements()) {
      if (fieldTy->isPointerTy()) {
        hasPointerToRecord = true;
        break;
      }
    }
    
    visiting.erase(structTy);
    
    if (hasPointerToRecord) {
      rdsTypes.insert(structTy);
      return true;
    }
    
    return false;
  }
  
  // get all pointer fields in a struct that could point to RDS types
  std::vector<unsigned> getRDSPointerFields(StructType *structTy) {
    std::vector<unsigned> fields;
    
    if (!isRDSStructType(structTy))
      return fields;
    
    // collect all pointer fields and array of pointer fields
    for (unsigned i = 0; i < structTy->getNumElements(); ++i) {
      Type *fieldTy = structTy->getElementType(i);
      if (fieldTy->isPointerTy()) {
        fields.push_back(i);
      }
      // check for array of pointers
      else if (auto *arrayTy = dyn_cast<ArrayType>(fieldTy)) {
        if (arrayTy->getElementType()->isPointerTy()) {
          fields.push_back(i);
        }
      }
    }
    
    return fields;
  }
};

// detect recurrent pointer updates in loops
bool detectRecurrentPointerUpdate(Loop *L, Value *&pointerVar) {
  for (BasicBlock *BB : L->blocks()) {
    for (Instruction &I : *BB) {
      // look for store instructions
      if (auto *store = dyn_cast<StoreInst>(&I)) {
        Value *storedValue = store->getValueOperand();
        Value *storePtr = store->getPointerOperand();
        
        // check if stored value comes from a load through a GEP
        if (auto *load = dyn_cast<LoadInst>(storedValue)) {
          Value *loadPtr = load->getPointerOperand();
          
          // check if this is a GEP (struct field access)
          if (auto *gep = dyn_cast<GetElementPtrInst>(loadPtr)) {
            Value *basePtr = gep->getPointerOperand();
            
            // check if base is loaded from the same variable we're storing to
            if (auto *baseLoad = dyn_cast<LoadInst>(basePtr)) {
              if (baseLoad->getPointerOperand() == storePtr) {
                // found recurrent update: p = p->field
                pointerVar = storePtr;
                return true;
              }
            }
          }
        }
      }
    }
  }
  return false;
}

// get struct type from a value if it points to a struct
StructType* getPointedStructType(Value *V) {
  Type *ty = V->getType();
  
  // for alloca instructions
  if (auto *alloca = dyn_cast<AllocaInst>(V)) {
    Type *allocatedTy = alloca->getAllocatedType();
    if (auto *structTy = dyn_cast<StructType>(allocatedTy)) {
      return structTy;
    }
  }
  
  // for function arguments - infer from how they're used
  if (auto *arg = dyn_cast<Argument>(V)) {
    // look at all uses of this argument to find GEP operations
    for (User *U : arg->users()) {
      if (auto *gep = dyn_cast<GetElementPtrInst>(U)) {
        if (auto *structTy = dyn_cast<StructType>(gep->getSourceElementType())) {
          return structTy;
        }
      }
    }
  }
  
  // for load instructions that load pointers
  if (auto *load = dyn_cast<LoadInst>(V)) {
    // check what this load is loading from
    Value *loadFrom = load->getPointerOperand();
    if (auto *gep = dyn_cast<GetElementPtrInst>(loadFrom)) {
      // loading from a GEP - get the struct type
      Type *gepSourceType = gep->getSourceElementType();
      if (auto *structTy = dyn_cast<StructType>(gepSourceType)) {
        return structTy;
      }
      
      // handle array of pointers within struct
      if (auto *arrayType = dyn_cast<ArrayType>(gepSourceType)) {
        // GEP indexes into an array - trace back to find parent struct
        Value *arrayBase = gep->getPointerOperand();
        if (auto *parentGEP = dyn_cast<GetElementPtrInst>(arrayBase)) {
          if (auto *structTy = dyn_cast<StructType>(parentGEP->getSourceElementType())) {
            return structTy;
          }
        }
      }
    }
    
    // try to infer from usage patterns
    for (User *U : V->users()) {
      if (auto *gep = dyn_cast<GetElementPtrInst>(U)) {
        if (auto *structTy = dyn_cast<StructType>(gep->getSourceElementType())) {
          return structTy;
        }
      }
    }
  }
  
  // for GEP instructions
  if (auto *gep = dyn_cast<GetElementPtrInst>(V)) {
    if (auto *structTy = dyn_cast<StructType>(gep->getSourceElementType())) {
      return structTy;
    }
  }
  
  return nullptr;
}

enum class PrefetchStrategy {
  GREEDY,      // prefetch all pointer fields
  SELECTIVE    // only prefetch pointers not accessed immediately
};

struct RDSPrefetchPass : public PassInfoMixin<RDSPrefetchPass> {
  
  RDSTypeAnalyzer typeAnalyzer;
  PrefetchStrategy strategy = PrefetchStrategy::GREEDY;
  bool enableNullCheck = false;
  
  RDSPrefetchPass() = default;
  RDSPrefetchPass(PrefetchStrategy s) : strategy(s) {}
  
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    bool modified = false;
    
    errs() << "RDS Prefetch Pass on function : " << F.getName() << "\n";
    
    // get loop info for detecting traversals
    LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
    
    errs() << "  Number of loops : " << LI.getLoopsInPreorder().size() << "\n";
    
    // phase 1: recognize RDS types in this function by scanning GEP instructions
    std::set<StructType*> functionRDSTypes;
    for (BasicBlock &BB : F) {
      for (Instruction &I : BB) {
        // check AllocaInst for stack-allocated structs
        if (auto *allocaInst = dyn_cast<AllocaInst>(&I)) {
          Type *allocatedTy = allocaInst->getAllocatedType();
          if (auto *structTy = dyn_cast<StructType>(allocatedTy)) {
            if (typeAnalyzer.isRDSStructType(structTy)) {
              functionRDSTypes.insert(structTy);
              errs() << "  Found RDS type : " << structTy->getName().str() << "\n";
            }
          }
        }
        // check GEP for heap-allocated structs (from malloc)
        else if (auto *gep = dyn_cast<GetElementPtrInst>(&I)) {
          if (auto *structTy = dyn_cast<StructType>(gep->getSourceElementType())) {
            if (typeAnalyzer.isRDSStructType(structTy)) {
              functionRDSTypes.insert(structTy);
              errs() << "  Found RDS type : " << structTy->getName().str() << "\n";
            }
          }
        }
      }
    }
    
    errs() << "  Total RDS types found : " << functionRDSTypes.size() << "\n";
    
    // phase 2: detect RDS traversals in loops
    for (Loop *L : LI) {
      errs() << "  Processing a loop\n";
      modified |= processLoop(L, F);
    }
    
    // phase 3: detect RDS traversals in recursive calls
    modified |= processRecursiveCalls(F);
    
    if (modified) {
      errs() << "  *** Modified function with prefetch instructions ***\n";
      PreservedAnalyses PA;
      PA.preserve<LoopAnalysis>();
      return PA;
    }
    
    errs() << "  No modifications made\n";
    return PreservedAnalyses::all();
  }
  
  // process a loop to find and prefetch RDS traversals
  bool processLoop(Loop *L, Function &F) {
    bool modified = false;
    
    // track which RDS nodes we've already prefetched in this loop to avoid duplicates
    std::set<Value*> prefetchedNodes;
    
    // look for loads of RDS node pointers that we should prefetch from
    for (BasicBlock *BB : L->blocks()) {
      for (Instruction &I : *BB) {
        // look for loads that load a pointer
        if (auto *load = dyn_cast<LoadInst>(&I)) {
          if (!load->getType()->isPointerTy())
            continue;
            
          // check if this load is used by a GEP that accesses an RDS struct
          bool foundRDS = false;
          for (User *U : load->users()) {
            if (auto *gep = dyn_cast<GetElementPtrInst>(U)) {
              if (auto *structTy = dyn_cast<StructType>(gep->getSourceElementType())) {
                if (typeAnalyzer.isRDSStructType(structTy)) {
                  // RDS access found - insert prefetches if we haven't already
                  if (prefetchedNodes.insert(load).second) {
                    modified |= insertGreedyPrefetches(load, structTy, load->getNextNode());
                  }
                  foundRDS = true;
                  break; // only need to prefetch once per load
                }
              }
            }
          }
          if (foundRDS) break; // found what we need in this BB
        }
      }
    }
    
    return modified;
  }
  
  // process recursive function calls
  bool processRecursiveCalls(Function &F) {
    bool modified = false;
    
    for (BasicBlock &BB : F) {
      for (Instruction &I : BB) {
        if (auto *call = dyn_cast<CallInst>(&I)) {
          Function *calledFunc = call->getCalledFunction();
          
          // check for recursive call
          if (calledFunc == &F) {
            errs() << "  Found recursive call\n";
            
            // check arguments for RDS pointers
            for (unsigned i = 0; i < call->arg_size(); ++i) {
              Value *arg = call->getArgOperand(i);
              
              // try to determine if this is an RDS pointer
              if (arg->getType()->isPointerTy()) {
                // check if we can find the struct type
                StructType *structTy = getPointedStructType(arg);
                if (structTy && typeAnalyzer.isRDSStructType(structTy)) {
                  // insert prefetches before the recursive call
                  modified |= insertPrefetchesForValue(arg, structTy, &I);
                }
              }
            }
          }
        }
      }
    }
    
    return modified;
  }
  
  // analyze which pointer fields are accessed immediately (selective mode)
  std::set<unsigned> getImmediatelyAccessedFields(LoadInst *nodeLoad, StructType *structTy) {
    std::set<unsigned> immediateFields;
    
    // look at all uses of this loaded pointer
    for (User *U : nodeLoad->users()) {
      if (auto *gep = dyn_cast<GetElementPtrInst>(U)) {
        // check if this GEP accesses a struct field
        if (gep->getNumIndices() >= 2) {
          auto idxIt = gep->idx_begin();
          ++idxIt; // skip first index
          if (auto *fieldIdx = dyn_cast<ConstantInt>(idxIt)) {
            immediateFields.insert(fieldIdx->getZExtValue());
          }
        }
      }
    }
    
    return immediateFields;
  }
  
  // insert prefetches for an RDS node access (greedy or selective)
  bool insertGreedyPrefetches(LoadInst *nodeLoad, StructType *structTy, Instruction *insertPt) {
    bool modified = false;
    
    // get all RDS pointer fields in this struct
    std::vector<unsigned> rdsFields = typeAnalyzer.getRDSPointerFields(structTy);
    
    if (rdsFields.empty())
      return false;
    
    // selective : filter out immediately accessed fields
    std::vector<unsigned> fieldsToPrefetch;
    if (strategy == PrefetchStrategy::SELECTIVE) {
      std::set<unsigned> immediateFields = getImmediatelyAccessedFields(nodeLoad, structTy);
      for (unsigned fieldIdx : rdsFields) {
        if (immediateFields.find(fieldIdx) == immediateFields.end()) {
          fieldsToPrefetch.push_back(fieldIdx);  // not accessed immediately - prefetch
        }
      }
      errs() << "    Selective : " << fieldsToPrefetch.size() << " of " << rdsFields.size() << 
                " fields need prefetch (filtered " << immediateFields.size() << " immediate)\n";
    } else {
      fieldsToPrefetch = rdsFields;  // greedy : prefetch everything
      errs() << "    Greedy : inserting " << fieldsToPrefetch.size() << " prefetches\n";
    }
    
    if (fieldsToPrefetch.empty())
      return false;
    
    // insert prefetches for each selected field
    IRBuilder<> builder(insertPt);
    
    for (unsigned fieldIdx : fieldsToPrefetch) {
      // create GEP to access the field
      Value *indices[] = {
        builder.getInt32(0),
        builder.getInt32(fieldIdx)
      };
      
      Value *fieldPtr = builder.CreateInBoundsGEP(
        structTy,
        nodeLoad,
        indices,
        "rds.field.ptr"
      );
      
      // load the pointer value (natural jump pointer)
      Value *fieldValue = builder.CreateLoad(
        builder.getPtrTy(),
        fieldPtr,
        "rds.field.val"
      );
      
      // insert prefetch for the node pointed to by this field
      insertPrefetch(builder, fieldValue);
      modified = true;
    }
    
    return modified;
  }
  
  // insert prefetches for a value
  bool insertPrefetchesForValue(Value *nodePtr, StructType *structTy, Instruction *insertBefore) {
    bool modified = false;
    
    // get all RDS pointer fields in this struct
    std::vector<unsigned> rdsFields = typeAnalyzer.getRDSPointerFields(structTy);
    
    if (rdsFields.empty())
      return false;
    
    // recursive calls with selective : only prefetch if depth allows
    std::vector<unsigned> fieldsToPrefetch;
    if (strategy == PrefetchStrategy::SELECTIVE && rdsFields.size() > 1) {
      // selective : only prefetch the first pointer field
      fieldsToPrefetch.push_back(rdsFields[0]);
      errs() << "    Selective: inserting " << fieldsToPrefetch.size() << " of " << rdsFields.size() << " prefetches for recursive call\n";
    } else {
      // greedy : prefetch all pointer fields
      fieldsToPrefetch = rdsFields;
      errs() << "    Greedy: inserting " << fieldsToPrefetch.size() << " prefetches for recursive call\n";
    }
    
    IRBuilder<> builder(insertBefore);
    
    for (unsigned fieldIdx : fieldsToPrefetch) {
      // create GEP to access the field
      Value *indices[] = {
        builder.getInt32(0),
        builder.getInt32(fieldIdx)
      };
      
      Value *fieldPtr = builder.CreateInBoundsGEP(
        structTy,
        nodePtr,
        indices,
        "rds.field.ptr"
      );
      
      // load the pointer value
      Value *fieldValue = builder.CreateLoad(
        builder.getPtrTy(),
        fieldPtr,
        "rds.field.val"
      );
      
      // check for NULL before prefetching
      if (enableNullCheck) {
        insertConditionalPrefetch(builder, fieldValue);
      } else {
        insertPrefetch(builder, fieldValue);
      }
      
      modified = true;
    }
    
    return modified;
  }
  
  // insert a prefetch intrinsic
  void insertPrefetch(IRBuilder<> &builder, Value *address) {
    
    Module *M = builder.GetInsertBlock()->getModule();
    
    // get or create the llvm.prefetch intrinsic
    Function *prefetchFunc = Intrinsic::getDeclaration(
      M,
      Intrinsic::prefetch,
      address->getType()
    );
    
    // create prefetch call - prefetch(address, rw=0 (read), locality = 3 (high), cache type = 1 (data))
    Value *args[] = {
      address,
      builder.getInt32(0),  // rw : 0 = read, 1 = write
      builder.getInt32(3),  // locality : 0 - 3 (3 = highest)
      builder.getInt32(1)   // cache type : 1 = data cache
    };
    
    builder.CreateCall(prefetchFunc, args);
  }
  
  // insert a conditional prefetch with NULL check to reduce overhead
  void insertConditionalPrefetch(IRBuilder<> &builder, Value *address) {
    
    // check if address is NULL
    Value *isNull = builder.CreateIsNull(address, "is.null");
    
    // create basic blocks for conditional
    BasicBlock *currentBB = builder.GetInsertBlock();
    Function *F = currentBB->getParent();
    BasicBlock *prefetchBB = BasicBlock::Create(F->getContext(), "do.prefetch", F);
    BasicBlock *continueBB = BasicBlock::Create(F->getContext(), "continue", F);
    
    // branch based on NULL check
    builder.CreateCondBr(isNull, continueBB, prefetchBB);
    
    // insert prefetch in prefetchBB
    builder.SetInsertPoint(prefetchBB);
    insertPrefetch(builder, address);
    builder.CreateBr(continueBB);
    
    // continue execution
    builder.SetInsertPoint(continueBB);
  }
};

}

// register the pass
extern "C" ::llvm::PassPluginLibraryInfo LLVM_ATTRIBUTE_WEAK llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "RDSPrefetchPass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "rds-prefetch-greedy") {
            FPM.addPass(RDSPrefetchPass(PrefetchStrategy::GREEDY));
            return true;
          }
          if (Name == "rds-prefetch-selective") {
            FPM.addPass(RDSPrefetchPass(PrefetchStrategy::SELECTIVE));
            return true;
          }
          if (Name == "rds-prefetch") {
            FPM.addPass(RDSPrefetchPass());
            return true;
          }
          return false;
        }
      );
    }
  };
}
