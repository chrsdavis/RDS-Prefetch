#!/bin/bash

# ================= 配置区域 =================
# 请确认 Pass 路径正确
PASS_LIB="/n/eecs583a/home/lxxy/RDS-Prefetch/RDS_Prefetch/build/rds_pass/libRDSPrefetchPass.so"
PASS_NAME="rds-prefetch-greedy"

# 根据 Makefile 的 RUN_OPTIONS 设置参数
# 如果运行太快 (0.00s)，请按比例增大这两个数，例如 "3000 200000"
ARGS="6000 100000"

# ===========================================

echo "========================================"
echo "Building FT Benchmark..."

# 1. 清理环境
rm -f *.bc *.o ft_base ft_opt

# 2. 编译所有 .c 文件并链接
# ft 通常由多个源文件组成，使用 *.c 确保全部包含
clang -O1 -emit-llvm -c *.c -Xclang -disable-llvm-passes 2>/dev/null
llvm-link *.bc -o ft.bc 2>/dev/null

if [ ! -f "ft.bc" ]; then
    echo "Error: Failed to generate bitcode. Check if .c files exist."
    exit 1
fi

# 3. 运行 Pass 优化
opt -load-pass-plugin="$PASS_LIB" -passes="$PASS_NAME" ft.bc -o ft_opt.bc 2>/dev/null
count=$(llvm-dis ft_opt.bc -o - | grep -c "llvm.prefetch")
echo "  > Prefetches inserted: $count"

# 4. 生成可执行文件 (-lm 用于链接数学库，很多 ft 程序需要)
clang -O2 ft.bc -o ft_base -lm 2>/dev/null
clang -O2 ft_opt.bc -o ft_opt -lm 2>/dev/null

echo "========================================"
echo "Running Performance Test..."
echo "Args: $ARGS"

# =========================================================================
# 运行对比 (使用 命令行参数 $ARGS)
# =========================================================================

# --- 测量 Baseline ---
echo -n "  > Running Baseline... "
start_base=$(date +%s%N)

# 注意：这里直接把 $ARGS 传给程序，而不是用 < 重定向
./ft_base $ARGS > /dev/null 2>&1

end_base=$(date +%s%N)
t_base=$(echo "scale=4; ($end_base - $start_base) / 1000000000" | bc)
echo "Done ($t_base s)."

# --- 测量 Optimized ---
echo -n "  > Running Optimized... "
start_opt=$(date +%s%N)

./ft_opt $ARGS > /dev/null 2>&1

end_opt=$(date +%s%N)
t_opt=$(echo "scale=4; ($end_opt - $start_opt) / 1000000000" | bc)
echo "Done ($t_opt s)."

# =========================================================================

echo ""
echo "========================================"
echo "           FINAL RESULTS                "
echo "========================================"

awk -v b="$t_base" -v o="$t_opt" -v c="$count" 'BEGIN {
    printf "%-15s | %-15s\n", "Metric", "Value"
    print "----------------|----------------"
    printf "%-15s | %s\n", "Prefetches", c
    printf "%-15s | %.4f s\n", "Baseline Time", b
    printf "%-15s | %.4f s\n", "Optimized Time", o
    print "----------------|----------------"
    
    if (o > 0) {
        speedup = b / o
        printf "%-15s | %.4fx\n", "Speedup", speedup
    } else {
        printf "%-15s | %s\n", "Speedup", "Error"
    }
    print "========================================"
}'