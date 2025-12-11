#!/bin/bash

# ================= 配置区域 =================
# Pass 动态库的绝对路径
PASS_LIB="/n/eecs583a/home/lxxy/RDS-Prefetch/RDS_Prefetch/build/rds_pass/libRDSPrefetchPass.so"

# 你的 Pass 注册名称 (根据之前的对话可能是 rds-prefetch-greedy 或 rds-prefetch-selective)
# 如果你想测 selective，请修改这里
PASS_NAME="rds-prefetch-greedy"

# 设置比较小的运行参数以便快速测试 (Small Problem Size)
declare -A BENCH_ARGS
BENCH_ARGS["bh"]="2000 5"             # Body count, Timesteps
BENCH_ARGS["bisort"]="10000000"         # Number of numbers
BENCH_ARGS["em3d"]="1000 100 0"       # Nodes, Degree, Percent remote
BENCH_ARGS["health"]="5 500"          # Level, Time
BENCH_ARGS["mst"]="1024"              # Graph nodes
BENCH_ARGS["perimeter"]="10"          # Tree level
BENCH_ARGS["power"]=""                # Power usually has no args or hardcoded
BENCH_ARGS["treeadd"]="20"            # Tree level
BENCH_ARGS["tsp"]="100000"            # Cities
BENCH_ARGS["voronoi"]="20000"         # Points

# 编译标志 (源自 Makefile -DTORONTO 等)
COMMON_FLAGS="-O1 -DTORONTO -fno-strict-aliasing"
LINK_FLAGS="-lm" # 数学库

# ===========================================

# 检查 Pass 是否存在
if [ ! -f "$PASS_LIB" ]; then
    echo "Error: Pass library not found at $PASS_LIB"
    exit 1
fi

echo "=========================================================="
echo "Running All Olden Benchmarks with Pass: $PASS_NAME"
echo "=========================================================="
echo ""

# 获取当前目录下所有的子文件夹 (即各个 Benchmark)
for bench_dir in */; do
    bench_name=$(basename "$bench_dir")
    
    # 跳过非 Benchmark 目录 (如果有)
    if [ ! -d "$bench_name" ]; then continue; fi
    
    echo "----------------------------------------------------------"
    echo "Testing: $bench_name"
    
    # 进入 Benchmark 目录
    cd "$bench_name" || continue
    
    # 1. 清理旧文件
    rm -f *.bc *.ll *_base *_opt *.o
    
    # 2. 将所有 .c 文件编译为 LLVM IR (.bc)
    # 使用 -Xclang -disable-llvm-passes 确保 IR 是纯净的
    clang $COMMON_FLAGS -emit-llvm -c *.c -Xclang -disable-llvm-passes > /dev/null 2>&1
    
    # 3. 链接所有 .bc 文件为一个文件 (比如 bh.bc)
    llvm-link *.bc -o "${bench_name}_combined.bc" > /dev/null 2>&1
    
    if [ ! -f "${bench_name}_combined.bc" ]; then
        echo "  [Compile Error] Failed to generate bitcode for $bench_name"
        cd ..
        continue
    fi
    
    # 4. 生成 Baseline 可执行文件 (无 Pass)
    clang -O2 "${bench_name}_combined.bc" -o "${bench_name}_base" $LINK_FLAGS > /dev/null 2>&1
    
    # 5. 运行你的 Pass 并在 IR 上进行优化
    # 注意：这里会尝试加载你的 Pass
    opt -load-pass-plugin="$PASS_LIB" \
        -passes="$PASS_NAME" \
        "${bench_name}_combined.bc" \
        -o "${bench_name}_opt.bc" > /dev/null 2>&1
        
    # 统计插入了多少条 Prefetch (可选检查)
    PREFETCH_COUNT=$(llvm-dis "${bench_name}_opt.bc" -o - | grep -c "llvm.prefetch")
    echo "  > Pass applied. Prefetches inserted: $PREFETCH_COUNT"
    
    # 6. 生成 Optimized 可执行文件
    clang -O2 "${bench_name}_opt.bc" -o "${bench_name}_opt" $LINK_FLAGS > /dev/null 2>&1
    
    # 7. 运行性能对比
    ARGS=${BENCH_ARGS[$bench_name]}
    echo "  > Running with args: $ARGS"
    
    # 使用 /usr/bin/time 测量时间 (更稳健)
    # 格式 %e 表示只输出秒数
    if [ -f "${bench_name}_base" ] && [ -f "${bench_name}_opt" ]; then
        # 运行 Baseline
        T_BASE=$(/usr/bin/time -f "%e" ./"${bench_name}_base" $ARGS 2>&1 > /dev/null)
        
        # 运行 Optimized
        T_OPT=$(/usr/bin/time -f "%e" ./"${bench_name}_opt" $ARGS 2>&1 > /dev/null)
        
        # 计算加速比
        if (( $(echo "$T_OPT > 0" | bc -l) )); then
            SPEEDUP=$(echo "$T_BASE / $T_OPT" | bc -l)
            printf "  > [Result] Base: %.3fs | Opt: %.3fs | Speedup: %.2fx\n" "$T_BASE" "$T_OPT" "$SPEEDUP"
        else
            echo "  > [Error] Optimized run time is 0 or failed."
        fi
    else
        echo "  > [Error] Compilation failed."
    fi
    
    # 返回上一级目录
    cd ..
    echo ""
done