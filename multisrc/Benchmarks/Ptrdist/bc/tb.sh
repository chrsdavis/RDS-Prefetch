#!/bin/bash

# ================= 配置 =================
PASS_LIB="/n/eecs583a/home/lxxy/RDS-Prefetch/RDS_Prefetch/build/rds_pass/libRDSPrefetchPass.so"
PASS_NAME="rds-prefetch-greedy"
INPUT_FILE="primes.b"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: $INPUT_FILE not found."
    exit 1
fi

echo "========================================"
echo "Building BC Benchmark..."

# 1. 清理
rm -f *.bc *.o bc_base bc_opt

# 2. 编译所有 .c 文件并链接
# bc 由多个文件组成 (scan.c util.c main.c 等)，不能只编译一个
clang -O1 -emit-llvm -c *.c -Xclang -disable-llvm-passes 2>/dev/null
llvm-link *.bc -o bc.bc 2>/dev/null

# 3. 运行 Pass 优化
opt -load-pass-plugin="$PASS_LIB" -passes="$PASS_NAME" bc.bc -o bc_opt.bc 2>/dev/null
count=$(llvm-dis bc_opt.bc -o - | grep -c "llvm.prefetch")
echo "  > Prefetches inserted: $count"

# 4. 生成可执行文件
clang -O2 bc.bc -o bc_base -lm 2>/dev/null
clang -O2 bc_opt.bc -o bc_opt -lm 2>/dev/null

echo "========================================"
echo "Running Performance Test..."

# =========================================================================
# 运行对比 (使用 input redirection < )
# =========================================================================

# --- 测量 Baseline ---
echo -n "  > Running Baseline... "
start_base=$(date +%s%N)
./bc_base < "$INPUT_FILE" > /dev/null 2>&1
end_base=$(date +%s%N)
t_base=$(echo "scale=4; ($end_base - $start_base) / 1000000000" | bc)
echo "Done ($t_base s)."

# --- 测量 Optimized ---
echo -n "  > Running Optimized... "
start_opt=$(date +%s%N)
./bc_opt < "$INPUT_FILE" > /dev/null 2>&1
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