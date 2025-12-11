#!/bin/bash

# Assuming you installed LLVM with Homebrew

# Set environment
export LLVM_DIR=$(brew --prefix llvm)/lib/cmake/llvm/
export CXX=$(brew --prefix llvm)/bin/clang++
export CC=$(brew --prefix llvm)/bin/clang

# Clean and build
rm -rf build
mkdir build && cd build

# Configure with verbose output
cmake -DLLVM_DIR="$LLVM_DIR" \
      -DCMAKE_CXX_COMPILER="$CXX" \
      ..

# Build
make -j

# Check if library was created
if [ -f rds_pass/libRDSPrefetchPass.so ]; then
    echo "Build successful! Library created: rds_pass/libRDSPrefetchPass.so"
    ls -la rds_pass/libRDSPrefetchPass.so
else
    echo "Build failed!"
fi