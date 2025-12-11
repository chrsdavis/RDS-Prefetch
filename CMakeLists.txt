# CMakeLists.txt

cmake_minimum_required(VERSION 3.13.4)
project(RDS_Prefetch)

find_package(LLVM REQUIRED CONFIG)

# Get LLVM package info
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "LLVM include dir: ${LLVM_INCLUDE_DIRS}")
message(STATUS "LLVM library dir: ${LLVM_LIBRARY_DIRS}")

# Include directories and definitions
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# Set C++ standard (required for LLVM 18)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_subdirectory(rds_pass)
