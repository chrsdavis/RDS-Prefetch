#!/bin/bash

# ================= 配置 =================
PASS_LIB="/n/eecs583a/home/lxxy/RDS-Prefetch/RDS_Prefetch/build/rds_pass/libRDSPrefetchPass.so"
PASS_NAME="rds-prefetch-greedy"
INPUT_FILE="input.large"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: $INPUT_FILE not found."
    exit 1
fi

echo "========================================"
echo "Building Anagram Benchmark..."

# 1. 编译 (静默)
clang -O1 -emit-llvm -c anagram.c -o anagram.bc -Xclang -disable-llvm-passes 2>/dev/null
opt -load-pass-plugin="$PASS_LIB" -passes="$PASS_NAME" anagram.bc -o anagram_opt.bc 2>/dev/null
count=$(llvm-dis anagram_opt.bc -o - | grep -c "llvm.prefetch")
echo "  > Prefetches inserted: $count"

# 2. 生成可执行文件
clang -O2 anagram.bc -o anagram_base 2>/dev/null
clang -O2 anagram_opt.bc -o anagram_opt 2>/dev/null

echo "========================================"
echo "Running Performance Test..."

# =========================================================================
# 核心修正：使用 date +%s%N 计算时间差
# 这种方法绝对不会抓到程序的垃圾输出，也不会为空
# =========================================================================

# --- 测量 Baseline ---
echo -n "  > Running Baseline... "
start_base=$(date +%s%N)
./anagram_base words 2 < "$INPUT_FILE" > /dev/null 2>&1
end_base=$(date +%s%N)
# 计算秒数 (纳秒差值 / 10^9)
t_base=$(echo "scale=4; ($end_base - $start_base) / 1000000000" | bc)
echo "Done ($t_base s)."

# --- 测量 Optimized ---
echo -n "  > Running Optimized... "
start_opt=$(date +%s%N)
./anagram_opt words 2 < "$INPUT_FILE" > /dev/null 2>&1
end_opt=$(date +%s%N)
# 计算秒数
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