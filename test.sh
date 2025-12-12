#!/usr/bin/env bash

# Automated driver for RDS prefetch experiments.
# Run from the MultiSource directory (where Makefile.rds lives).

REPO_ROOT="$(realpath "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")"
export RDS_ROOT="${REPO_ROOT}"
echo "RDS_ROOT set to ${RDS_ROOT}"

SCRIPT_DIR="$(realpath "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")"
BENCH_ROOT="$(realpath "${SCRIPT_DIR}/multisrc/Benchmarks")"

OLDEN_DIR="$(realpath "${BENCH_ROOT}/Olden")"
PTRDIST_DIR="$(realpath "${BENCH_ROOT}/Ptrdist")"
CUSTOM_DIR="$(realpath "${BENCH_ROOT}/RDS")"

# Program lists (adapt to your tree if needed)
OLDEN_PROGS=(bh bisort em3d health mst perimeter power treeadd tsp voronoi)
PTRDIST_PROGS=(anagram bc ft ks yacr2)
CUSTOM_PROGS=(binaryTree linkedList doublyLinkedList ternaryTree treeWithParent graphTraversal)

NUM_RUNS=3

usage() {
  cat <<EOF
Usage:
  $0 olden           # run all Olden benchmarks
  $0 ptrdist         # run all Ptrdist benchmarks
  $0 rds             # run all custom RDS benchmarks
  $0 all             # run all Olden + Ptrdist + RDS benchmarks
  $0 <prog>          # run single program (e.g., em3d, bh, anagram, binaryTree, ...)

The script expects to be placed in the repo root and uses:
  multisrc/Benchmarks/Olden/<prog>
  multisrc/Benchmarks/Ptrdist/<prog>
  multisrc/Benchmarks/RDS/<prog>
EOF
}

prog_in_array() {
  local needle="$1"; shift
  local x
  for x in "$@"; do
    if [[ "$x" == "$needle" ]]; then
      return 0
    fi
  done
  return 1
}

extract_miss_rate() {
  # $1: perf output file
  awk '
    function get_rate(file) {
      misses = 0; refs = 0;
      while ((getline line < file) > 0) {
        if (line ~ /cache-misses/) {
          gsub(/,/, "", line);
          split(line, a, " ");
          misses = a[1];
        }
        if (line ~ /cache-references/) {
          gsub(/,/, "", line);
          split(line, a, " ");
          refs = a[1];
        }
      }
      close(file);
      if (refs > 0) return (misses / refs) * 100;
      return 0;
    }
    BEGIN {
      rate = get_rate(ARGV[1]);
      print rate;
    }
  ' "$1"
}

avg_from_file() {
  # prints average of numbers (one per line), or 0 if file missing/empty
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "0"
    return
  fi
  awk '{s+=$1; n++} END { if (n>0) printf "%.6f\n", s/n; else print 0 }' "$file"
}

run_one_program() {
  local bench_name="$1"   # Olden / Ptrdist / RDS
  local prog="$2"
  local dir

  if [[ "$bench_name" == "Olden" ]]; then
    dir="${OLDEN_DIR}/${prog}"
  elif [[ "$bench_name" == "Ptrdist" ]]; then
    dir="${PTRDIST_DIR}/${prog}"
  elif [[ "$bench_name" == "RDS" ]]; then
    dir="${CUSTOM_DIR}/${prog}"
  else
    echo "[WARN] Unknown benchmark family: ${bench_name}"
    return
  fi

  if [[ ! -d "$dir" ]]; then
    echo "[WARN] Directory not found for ${bench_name}/${prog}: ${dir}"
    return
  fi

  echo
  echo "=================================================================="
  echo "Benchmark: ${bench_name}/${prog}"
  echo "Directory: ${dir}"
  echo "Runs:      ${NUM_RUNS}"
  echo "=================================================================="

  cd "$dir" || { echo "[ERROR] Cannot cd into ${dir}"; return; }

  mkdir -p Output

  # Clear previous aggregated results
  rm -f Output/base.time.all Output/greedy.time.all Output/selective.time.all
  rm -f Output/perf_base.rate.all Output/perf_greedy.rate.all Output/perf_select.rate.all

  for run in $(seq 1 "${NUM_RUNS}"); do
    echo "--- Run ${run}/${NUM_RUNS}: make time ---"
    if ! make time >/dev/null 2>&1; then
      echo "[ERROR] make time failed for ${bench_name}/${prog} (run ${run})"
      continue
    fi

    base_t=$(cat Output/base.time 2>/dev/null || echo 0)
    greedy_t=$(cat Output/greedy.time 2>/dev/null || echo 0)
    selective_t=$(cat Output/selective.time 2>/dev/null || echo 0)

    echo "$base_t"      >> Output/base.time.all
    echo "$greedy_t"    >> Output/greedy.time.all
    echo "$selective_t" >> Output/selective.time.all

    echo "--- Run ${run}/${NUM_RUNS}: make perf ---"
    if ! make perf >/dev/null 2>&1; then
      echo "[ERROR] make perf failed for ${bench_name}/${prog} (run ${run})"
      continue
    fi

    base_rate=$(extract_miss_rate Output/perf_base.txt 2>/dev/null || echo 0)
    greedy_rate=$(extract_miss_rate Output/perf_greedy.txt 2>/dev/null || echo 0)
    select_rate=$(extract_miss_rate Output/perf_select.txt 2>/dev/null || echo 0)

    echo "$base_rate"   >> Output/perf_base.rate.all
    echo "$greedy_rate" >> Output/perf_greedy.rate.all
    echo "$select_rate" >> Output/perf_select.rate.all
  done

  # Compute averages
  base_avg=$(avg_from_file Output/base.time.all)
  greedy_avg=$(avg_from_file Output/greedy.time.all)
  select_avg=$(avg_from_file Output/selective.time.all)

  base_rate_avg=$(avg_from_file Output/perf_base.rate.all)
  greedy_rate_avg=$(avg_from_file Output/perf_greedy.rate.all)
  select_rate_avg=$(avg_from_file Output/perf_select.rate.all)

  greedy_speedup=$(awk -v b="$base_avg" -v g="$greedy_avg" '
    BEGIN {
      if (g > 0) printf "%.4fx", b/g;
      else       printf "N/A";
    }')
  select_speedup=$(awk -v b="$base_avg" -v s="$select_avg" '
    BEGIN {
      if (s > 0) printf "%.4fx", b/s;
      else       printf "N/A";
    }')

  greedy_improve=$(awk -v b="$base_rate_avg" -v g="$greedy_rate_avg" '
    BEGIN {
      if (b > 0) printf "%.2f%%", (b-g)/b*100.0;
      else       printf "N/A";
    }')
  select_improve=$(awk -v b="$base_rate_avg" -v s="$select_rate_avg" '
    BEGIN {
      if (b > 0) printf "%.2f%%", (b-s)/b*100.0;
      else       printf "N/A";
    }')

  echo
  echo "-------------------- Summary: ${bench_name}/${prog} --------------------"
  printf "Average Time (s):\n"
  printf "  Base      : %.6f\n" "$base_avg"
  printf "  Greedy    : %.6f  (speedup %s)\n" "$greedy_avg" "$greedy_speedup"
  printf "  Selective : %.6f  (speedup %s)\n" "$select_avg" "$select_speedup"
  echo
  printf "Average Miss Rate (%%):\n"
  printf "  Base      : %.4f\n" "$base_rate_avg"
  printf "  Greedy    : %.4f  (improvement %s)\n" "$greedy_rate_avg" "$greedy_improve"
  printf "  Selective : %.4f  (improvement %s)\n" "$select_rate_avg" "$select_improve"
  echo "------------------------------------------------------------------"

  cd "${SCRIPT_DIR}" || true
}

run_set() {
  local bench_name="$1"   # Olden / Ptrdist / RDS
  local -n progs_ref="$2" # bash nameref

  for p in "${progs_ref[@]}"; do
    run_one_program "$bench_name" "$p"
  done
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

arg="$(echo "$1" | tr '[:upper:]' '[:lower:]')"

case "$arg" in
  olden)
    run_set "Olden" OLDEN_PROGS
    ;;
  ptrdist)
    run_set "Ptrdist" PTRDIST_PROGS
    ;;
  rds)
    run_set "RDS" CUSTOM_PROGS
    ;;
  all)
    run_set "Olden"   OLDEN_PROGS
    run_set "Ptrdist" PTRDIST_PROGS
    run_set "RDS"     CUSTOM_PROGS
    ;;
  *)
    prog="$1"
    if prog_in_array "$prog" "${OLDEN_PROGS[@]}"; then
      run_one_program "Olden" "$prog"
    elif prog_in_array "$prog" "${PTRDIST_PROGS[@]}"; then
      run_one_program "Ptrdist" "$prog"
    elif prog_in_array "$prog" "${CUSTOM_PROGS[@]}"; then
      run_one_program "RDS" "$prog"
    else
      echo "[ERROR] Unknown program: $prog"
      echo "       Valid Olden   : ${OLDEN_PROGS[*]}"
      echo "       Valid Ptrdist : ${PTRDIST_PROGS[*]}"
      echo "       Valid RDS     : ${CUSTOM_PROGS[*]}"
      exit 1
    fi
    ;;
esac
