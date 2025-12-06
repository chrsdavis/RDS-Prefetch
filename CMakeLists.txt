# RdsPrefetch/CMakeLists.txt

cmake_minimum_required(VERSION 3.20)

project(RecursivePrefetchPass
    VERSION 0.1.0
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# --- Find LLVM ---
# TODO: make this work for the 583 server
# Point LLVM_DIR to <llvm-install>/lib/cmake/llvm when configuring, e.g.:
#   cmake -DLLVM_DIR=/usr/lib/llvm-18/lib/cmake/llvm ..
find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# Point CMake to LLVM's own CMake modules
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM) # add_llvm_pass_plugin, add_llvm_tool, etc.
include(HandleLLVMOptions)  # LLVM's warning/compile flags

# LLVM's CMake exports
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# --- Misc Project options ---
option(RPREFETCH_ENABLE_TESTS "Build tests for RecursivePrefetchPass" ON)

add_subdirectory(src)

if (RPREFETCH_ENABLE_TESTS)
  enable_testing()
  add_subdirectory(tests)
endif()
