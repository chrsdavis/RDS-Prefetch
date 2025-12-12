#!/usr/bin/env bash
set -euo pipefail

# Root of the repo (directory that contains "multisrc" and "build")
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MULTISRC_ROOT="${REPO_ROOT}/multisrc"
BENCH_ROOT="${MULTISRC_ROOT}/Benchmarks"

OLDEN_DIR="${BENCH_ROOT}/Olden"
PTRDIST_DIR="${BENCH_ROOT}/Ptrdist"
RDS_DIR="${BENCH_ROOT}/RDS"

# Program lists (keep in sync with test.sh)
OLDEN_PROGS=(bh bisort em3d health mst perimeter power treeadd tsp voronoi)
PTRDIST_PROGS=(anagram bc ft ks yacr2)
RDS_PROGS=(binaryTree linkedList doublyLinkedList ternaryTree treeWithParent graphTraversal)

DO_CLEAN_BENCHES=true
DO_CLEAN_BUILD=false

usage() {
  cat <<EOF
Usage:
  $0            # clean all Olden/Ptrdist/RDS benchmarks (make clean)
  $0 --all      # clean benchmarks + remove build/ directory
  $0 --build    # only remove build/ directory

This script should be run from the repo root (same level as "multisrc" and "build").
EOF
}

if [[ $# -gt 1 ]]; then
  usage
  exit 1
fi

if [[ $# -eq 1 ]]; then
  case "$1" in
    --all)
      DO_CLEAN_BENCHES=true
      DO_CLEAN_BUILD=true
      ;;
    --build)
      DO_CLEAN_BENCHES=false
      DO_CLEAN_BUILD=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "[ERROR] Unknown option: $1"
      usage
      exit 1
      ;;
  esac
fi

clean_one_dir() {
  local dir="$1"
  if [[ -d "$dir" ]]; then
    echo "  clean: $dir"
    # Ignore failures so one broken benchmark does not stop the whole clean
    (cd "$dir" && make clean >/dev/null 2>&1 || true)
  fi
}

clean_benchmarks() {
  echo "=================================================="
  echo "Cleaning benchmark intermediates (make clean)..."
  echo "Root: ${BENCH_ROOT}"
  echo "=================================================="

  # Olden
  for p in "${OLDEN_PROGS[@]}"; do
    clean_one_dir "${OLDEN_DIR}/${p}"
  done

  # Ptrdist
  for p in "${PTRDIST_PROGS[@]}"; do
    clean_one_dir "${PTRDIST_DIR}/${p}"
  done

  # RDS
  for p in "${RDS_PROGS[@]}"; do
    clean_one_dir "${RDS_DIR}/${p}"
  done

  echo "--------------------------------------------------"
  echo "Benchmark clean finished."
}

clean_build_dir() {
  local build_dir="${REPO_ROOT}/build"
  if [[ -d "$build_dir" ]]; then
    echo "=================================================="
    echo "Removing build directory: ${build_dir}"
    echo "=================================================="
    rm -rf "${build_dir}"
    echo "Build directory removed."
  else
    echo "No build directory to remove (${build_dir} not found)."
  fi
}

if [[ "${DO_CLEAN_BENCHES}" == "true" ]]; then
  clean_benchmarks
fi

if [[ "${DO_CLEAN_BUILD}" == "true" ]]; then
  clean_build_dir
fi

echo "Done."
