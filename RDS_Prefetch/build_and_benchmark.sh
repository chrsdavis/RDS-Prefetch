#!/bin/bash

set -e

OUTPUT_FILE="benchmark.txt"

if [ "$1" = "clean" ]; then
    rm -rf build
    rm -f "$OUTPUT_FILE"
    exit 0
fi

exec > >(tee "$OUTPUT_FILE") 2>&1

if [ -z "$1" ] || [ "$1" = "all" ]; then
    BENCHMARKS=(benchmarks/*.c)
else
    BENCHMARKS=("benchmarks/$1.c")
fi

echo "Building RDS Prefetch Pass"
mkdir -p build && cd build
cmake .. > /dev/null 2>&1
make > /dev/null 2>&1
cd ..
echo ""

for benchmark in "${BENCHMARKS[@]}"; do
    if [ ! -f "$benchmark" ]; then
        echo "Benchmark $benchmark not found"
        continue
    fi
    
    basename=$(basename "$benchmark" .c)
    echo "========================================"
    echo "Testing: $basename"
    echo "========================================"
    echo ""
    
    clang -O1 -Xclang -disable-llvm-passes -emit-llvm -S "$benchmark" -o "build/${basename}.ll" 2>/dev/null
    
    for strategy in greedy selective; do
        echo "--- Strategy: ${strategy} ---"
        opt -load-pass-plugin=build/rds_pass/libRDSPrefetchPass.so \
            -passes="rds-prefetch-${strategy}" \
            "build/${basename}.ll" \
            -S -o "build/${basename}_${strategy}.ll" 2>/dev/null
        
        PREFETCH_COUNT=$(grep -c "llvm.prefetch" "build/${basename}_${strategy}.ll" || echo "0")
        echo "Prefetches inserted: ${PREFETCH_COUNT}"
        clang -O2 "build/${basename}_${strategy}.ll" -o "build/${basename}_${strategy}" 2>/dev/null
        echo ""
    done
    
    clang -O2 "build/${basename}.ll" -o "build/${basename}_nopf" 2>/dev/null
    
    if command -v perf &> /dev/null; then
        echo "========================================"
        echo "Performance Comparison"
        echo "========================================"
        echo ""
        
        echo "BASELINE (no prefetch) :"
        perf_nopf=$(perf stat -e cache-misses,cache-references "./build/${basename}_nopf" 10 2>&1)
        misses_nopf=$(echo "$perf_nopf" | grep "cache-misses" | grep -v "not counted" | grep -oP '^\s*\K[\d,]+' | tr -d ',' | awk '{sum+=$1} END {print sum}')
        rate_nopf=$(echo "$perf_nopf" | grep "cache-misses" | grep -v "not counted" | grep -oP '#\s+\K[\d.]+(?=% of all cache refs)' | head -1)
        
        if [ -n "$misses_nopf" ] && [ -n "$rate_nopf" ]; then
            echo "  Cache misses: ${misses_nopf} (${rate_nopf}% miss rate)"
        fi
        
        echo ""
        echo "GREEDY :"
        perf_greedy=$(perf stat -e cache-misses,cache-references "./build/${basename}_greedy" 10 2>&1)
        misses_greedy=$(echo "$perf_greedy" | grep "cache-misses" | grep -v "not counted" | grep -oP '^\s*\K[\d,]+' | tr -d ',' | awk '{sum+=$1} END {print sum}')
        rate_greedy=$(echo "$perf_greedy" | grep "cache-misses" | grep -v "not counted" | grep -oP '#\s+\K[\d.]+(?=% of all cache refs)' | head -1)
        
        if [ -n "$misses_greedy" ] && [ -n "$rate_greedy" ]; then
            echo "  Cache misses: ${misses_greedy} (${rate_greedy}% miss rate)"
        fi
        
        echo ""
        echo "SELECTIVE :"
        perf_selective=$(perf stat -e cache-misses,cache-references "./build/${basename}_selective" 10 2>&1)
        misses_selective=$(echo "$perf_selective" | grep "cache-misses" | grep -v "not counted" | grep -oP '^\s*\K[\d,]+' | tr -d ',' | awk '{sum+=$1} END {print sum}')
        rate_selective=$(echo "$perf_selective" | grep "cache-misses" | grep -v "not counted" | grep -oP '#\s+\K[\d.]+(?=% of all cache refs)' | head -1)
        
        if [ -n "$misses_selective" ] && [ -n "$rate_selective" ]; then
            echo "  Cache misses : ${misses_selective} (${rate_selective}% miss rate)"
        fi
        
        if [ -n "$misses_nopf" ] && [ -n "$misses_greedy" ] && [ -n "$misses_selective" ] && [ -n "$rate_nopf" ] && [ -n "$rate_greedy" ] && [ -n "$rate_selective" ]; then
            echo ""
            echo "========================================"
            echo "SUMMARY"
            echo "========================================"
            
            rate_improvement_greedy=$(awk "BEGIN {printf \"%.1f\", (($rate_nopf - $rate_greedy) / $rate_nopf) * 100}")
            rate_improvement_selective=$(awk "BEGIN {printf \"%.1f\", (($rate_nopf - $rate_selective) / $rate_nopf) * 100}")
            
            echo "Baseline :  ${rate_nopf}% miss rate"
            echo "Greedy :    ${rate_greedy}% miss rate (${rate_improvement_greedy}% improvement)"
            echo "Selective : ${rate_selective}% miss rate (${rate_improvement_selective}% improvement)"
        fi
    else
        echo "perf not available"
    fi
    
    echo ""
done
