#!/bin/bash

set -e

OUTPUT_FILE="benchmark.txt"

if [ "$1" = "clean" ]; then
    rm -rf build
    rm -f "$OUTPUT_FILE"
    exit 0
fi

# For macOS, use simpler redirection
if command -v tee >/dev/null 2>&1; then
    # Redirect both stdout and stderr to file AND terminal
    exec > >(tee "$OUTPUT_FILE") 2>&1
else
    # Fallback: just redirect to file
    exec > "$OUTPUT_FILE" 2>&1
fi

# Handle glob expansion
shopt -s nullglob

if [ -z "$1" ] || [ "$1" = "all" ]; then
    BENCHMARKS=(benchmarks/*.c)
    if [ ${#BENCHMARKS[@]} -eq 0 ]; then
        echo "No benchmark files found in benchmarks/"
        exit 1
    fi
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
    echo "BENCH"
    echo $benchmark
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
        
        # macOS-compatible grep (no -P flag)
        if command -v ggrep >/dev/null 2>&1; then
            # If GNU grep is installed as ggrep
            PREFETCH_COUNT=$(ggrep -c "llvm.prefetch" "build/${basename}_${strategy}.ll" 2>/dev/null || echo "0")
        else
            # BSD grep (macOS default) - use different approach
            PREFETCH_COUNT=$(grep "llvm.prefetch" "build/${basename}_${strategy}.ll" 2>/dev/null | wc -l | tr -d ' ' || echo "0")
        fi
        echo "Prefetches inserted: ${PREFETCH_COUNT}"
        clang -O2 "build/${basename}_${strategy}.ll" -o "build/${basename}_${strategy}" 2>/dev/null
        echo ""
    done
    
    clang -O2 "build/${basename}.ll" -o "build/${basename}_nopf" 2>/dev/null
    
    # Detect OS for performance measurement
    if [[ "$OSTYPE" == "linux-gnu"* ]] && command -v perf &> /dev/null; then
        echo "========================================"
        echo "Performance Comparison (Linux perf)"
        echo "========================================"
        echo ""
        
        echo "BASELINE (no prefetch) :"
        perf_nopf=$(perf stat -e cache-misses,cache-references "./build/${basename}_nopf" 10 2>&1)
        
        # macOS/BSD compatible parsing (no -P flag)
        misses_nopf=$(echo "$perf_nopf" | grep "cache-misses" | grep -v "not counted" | sed -E 's/^[[:space:]]*([0-9,]+).*/\1/' | tr -d ',' | awk '{sum+=$1} END {print sum}')
        rate_nopf=$(echo "$perf_nopf" | grep "cache-misses" | grep -v "not counted" | sed -E 's/.*# +([0-9.]+)% of all cache refs.*/\1/' | head -1)
        
        if [ -n "$misses_nopf" ] && [ -n "$rate_nopf" ]; then
            echo "  Cache misses: ${misses_nopf} (${rate_nopf}% miss rate)"
        fi
        
        # Similar fixes for greedy and selective sections...
        # Replace all grep -oP with sed -E or awk
        
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "========================================"
        echo "Performance Comparison (macOS)"
        echo "========================================"
        echo ""
        echo "Note: 'perf' is Linux-only. On macOS, consider using:"
        echo "  - 'time' command for elapsed time"
        echo "  - 'sudo dtruss' for system calls"
        echo "  - Instruments.app for profiling"
        echo ""
        
        # Simple timing comparison
        echo "BASELINE (no prefetch) timing:"
        time "./build/${basename}_nopf" 10 2>&1 | tail -3
        
        echo ""
        echo "GREEDY timing:"
        time "./build/${basename}_greedy" 10 2>&1 | tail -3
        
        echo ""
        echo "SELECTIVE timing:"
        time "./build/${basename}_selective" 10 2>&1 | tail -3
        
    else
        echo "Performance measurement not available on this platform"
    fi
    
    echo ""
done