#!/bin/bash

set -e

NUM_RUNS=10
OUTPUT_FILE="experiment_results.txt"
RESULTS_DIR="experiment_runs"

if [ -n "$1" ]; then
    NUM_RUNS=$1
fi

mkdir -p "$RESULTS_DIR"

declare -A baseline_misses
declare -A baseline_rates
declare -A greedy_misses
declare -A greedy_rates
declare -A selective_misses
declare -A selective_rates

for run in $(seq 1 $NUM_RUNS); do
    
    ./build_and_benchmark.sh > /dev/null 2>&1
    
    cp benchmark.txt "${RESULTS_DIR}/benchmark${run}.txt"
    
    current_config=""
    while IFS= read -r line; do
        if [[ $line =~ ^Testing:\ (.+)$ ]]; then
            current_bench="${BASH_REMATCH[1]}"
        elif [[ $line =~ ^BASELINE ]]; then
            current_config="baseline"
        elif [[ $line =~ ^GREEDY ]]; then
            current_config="greedy"
        elif [[ $line =~ ^SELECTIVE ]]; then
            current_config="selective"
        elif [[ $line =~ Cache\ misses\ ?:\ ([0-9]+).*\(([0-9.]+)%\ miss\ rate\) ]]; then
            if [[ $current_config == "baseline" ]]; then
                baseline_rates[$current_bench]+="${BASH_REMATCH[2]} "
            elif [[ $current_config == "greedy" ]]; then
                greedy_rates[$current_bench]+="${BASH_REMATCH[2]} "
            elif [[ $current_config == "selective" ]]; then
                selective_rates[$current_bench]+="${BASH_REMATCH[2]} "
            fi
        fi
    done < benchmark.txt
    
done

# Write results
{
    echo "Runs: ${NUM_RUNS}"
    echo ""
    
    for bench in "${!baseline_rates[@]}"; do
        echo "----------------------------------------"
        echo "Benchmark: $bench"
        echo "----------------------------------------"
        
        avg_baseline_rate=$(echo "${baseline_rates[$bench]}" | awk '{sum=0; for(i=1;i<=NF;i++) sum+=$i; printf "%.2f", sum/NF}')
        avg_greedy_rate=$(echo "${greedy_rates[$bench]}" | awk '{sum=0; for(i=1;i<=NF;i++) sum+=$i; printf "%.2f", sum/NF}')
        avg_selective_rate=$(echo "${selective_rates[$bench]}" | awk '{sum=0; for(i=1;i<=NF;i++) sum+=$i; printf "%.2f", sum/NF}')
        
        improvement_greedy=$(awk "BEGIN {printf \"%.1f\", (($avg_baseline_rate - $avg_greedy_rate) / $avg_baseline_rate) * 100}")
        improvement_selective=$(awk "BEGIN {printf \"%.1f\", (($avg_baseline_rate - $avg_selective_rate) / $avg_baseline_rate) * 100}")
        
        echo ""
        echo "Average Miss Rates (${NUM_RUNS} runs):"
        echo "  Baseline:  ${avg_baseline_rate}%"
        echo "  Greedy:    ${avg_greedy_rate}% (${improvement_greedy}% improvement)"
        echo "  Selective: ${avg_selective_rate}% (${improvement_selective}% improvement)"
        echo ""
    done
    
} | tee "$OUTPUT_FILE"

rm -f benchmark.txt
