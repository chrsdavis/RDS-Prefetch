#!/usr/bin/env bash
#
# Usage:
#   1) Run a single benchmark:
#        ./run_olden.sh bh
#        ./run_olden.sh bh 1024   # With arguments
#
#   2) Run all benchmarks:
#        ./run_olden.sh
#        ./run_olden.sh all
#
# Features:
#   - Compiles .c -> .bc -> link -> runs greedy-prefetch pass -> compiles to .exe
#   - Verifies correctness by diffing output
#   - Measures execution time
#
# Constraints:
#   - Compilation uses -O3 (Standard Optimization) + -g (Debug Info)
#   - Auto-vectorization is DISABLED to isolate prefetch benefits
#   - Single-threaded execution (Olden is inherently single-threaded)

set -euo pipefail

# ==== Configuration ====

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BENCH_ROOT="${ROOT_DIR}/olden"

# Path to your pass library and pass name
# Ensure this matches your build artifact location
PATH2LIB="${ROOT_DIR}/build/greedyPrefetchingPass/GreedyPrefetch.so"
PASS_NAME="greedy-prefetch"

# Default benchmark list
DEFAULT_BENCHES=(bh bisort em3d health mst perimeter power treeadd tsp voronoi)

# Linker flags (Single-threaded, no pthread/openmp)
COMMON_LIBS="-lm"

# Compiler Flags Explanation:
#   -O3                     : Enable standard optimizations (CRITICAL for prefetching to be useful)
#   -g                      : Generate debug info (makes .ll readable)
#   -fno-unroll-loops       : Disable loop unrolling to keep loop structure simple for analysis
#   -fno-vectorize          : Disable auto-vectorization to isolate prefetch gains
#   -fno-slp-vectorize      : Disable SLP vectorization
#   -fno-tree-vectorize     : Disable tree vectorization
#   -I${BENCH_ROOT}         : Fix "common/timing.h not found" error
CFLAGS="-O3 -g -std=gnu89 -DTORONTO \
        -fno-unroll-loops \
        -fno-vectorize \
        -fno-slp-vectorize \
        -fno-tree-vectorize \
        -Wno-deprecated-non-prototype \
        -Wno-implicit-int \
        -Wno-format-security \
        -I${BENCH_ROOT}"

# ==== Argument Parsing ====

BENCHES=()
PROG_ARGS=()

if [[ $# -eq 0 ]]; then
  # No args: run all benchmarks
  BENCHES=("${DEFAULT_BENCHES[@]}")
elif [[ "$1" == "all" ]]; then
  # Explicit "all": run all benchmarks
  BENCHES=("${DEFAULT_BENCHES[@]}")
  shift || true
  PROG_ARGS=("$@")
else
  # Specific benchmark: run only that one
  BENCHES=("$1")
  shift || true
  PROG_ARGS=("$@")
fi

if [[ ! -f "${PATH2LIB}" ]]; then
  echo "ERROR: Cannot find pass plugin at: ${PATH2LIB}"
  echo "Please verify that GreedyPrefetch.so is built successfully."
  exit 1
fi

# ==== Run Function ====

run_one_bench() {
  local bench="$1"
  shift || true
  local args=("$@")

  local src_dir="${BENCH_ROOT}/${bench}/src"

  echo
  echo "============================================================"
  echo ">>> Benchmark: ${bench}"
  echo ">>> Source dir: ${src_dir}"
  echo ">>> Arguments: ${args[*]}"
  echo "============================================================"

  if [[ ! -d "${src_dir}" ]]; then
    echo "WARNING: directory not found, skip: ${src_dir}"
    return
  fi

  pushd "${src_dir}" > /dev/null

  # Cleanup previous artifacts
  rm -f *.bc *.ll *.exe *_greedy.bc *_greedy.exe \
        greedy_output correct_output opt_${bench}.log

  # Find .c source files
  local srcs=(*.c)
  if [[ ${#srcs[@]} -eq 0 ]]; then
    echo "WARNING: no .c files in ${src_dir}, skip."
    popd > /dev/null
    return
  fi

  echo ">>> Compiling to LLVM bitcode (-O3 enabled)..."
  local bc_files=()
  for src in "${srcs[@]}"; do
    local base="${src%.c}"
    clang ${CFLAGS} -emit-llvm -c "${src}" \
          -Xclang -disable-O0-optnone \
          -o "${base}.bc"
    bc_files+=("${base}.bc")
  done

  echo ">>> Linking bitcode -> ${bench}.bc"
  llvm-link "${bc_files[@]}" -o "${bench}.bc"

  echo ">>> Building baseline executable: ${bench}.exe"
  clang ${CFLAGS} "${bench}.bc" -o "${bench}.exe" ${COMMON_LIBS}

  echo ">>> Running LLVM pass: ${PASS_NAME}"
  # Run opt and redirect stderr to log file to keep terminal clean
  if ! opt -load-pass-plugin="${PATH2LIB}" \
           -passes="${PASS_NAME}" \
           "${bench}.bc" -o "${bench}_greedy.bc" 2> "opt_${bench}.log"; then
    echo "ERROR: opt failed for benchmark ${bench}, see ${src_dir}/opt_${bench}.log"
    # Print the error log if failed
    cat "opt_${bench}.log"
    popd > /dev/null
    return
  fi

  echo ">>> Building optimized executable: ${bench}_greedy.exe"
  clang ${CFLAGS} "${bench}_greedy.bc" -o "${bench}_greedy.exe" ${COMMON_LIBS}

  echo ">>> Generating .ll for debugging (check for @llvm.prefetch)"
  llvm-dis "${bench}.bc"         -o "${bench}.ll"
  llvm-dis "${bench}_greedy.bc"  -o "${bench}_greedy.ll"

  echo ">>> Running programs for correctness check..."
  # Run both versions and capture output
  ./"${bench}.exe"        "${args[@]}" > correct_output
  ./"${bench}_greedy.exe" "${args[@]}" > greedy_output

  echo
  echo "=== Program Correctness Validation (${bench}) ==="
  if diff -q correct_output greedy_output > /dev/null; then
    echo ">> Outputs match"
  else
    echo ">> Outputs DO NOT match!"
    echo "   Check ${src_dir}/correct_output and greedy_output for differences."
  fi

  echo
  echo "1. Performance of baseline (${bench}.exe, -O3)"
  time ./"${bench}.exe" "${args[@]}" > /dev/null

  echo
  echo "2. Performance of optimized (${bench}_greedy.exe, -O3)"
  time ./"${bench}_greedy.exe" "${args[@]}" > /dev/null
  echo

  rm -f correct_output greedy_output

  popd > /dev/null
}

# ==== Main Loop ====

for b in "${BENCHES[@]}"; do
  run_one_bench "$b" "${PROG_ARGS[@]}"
done