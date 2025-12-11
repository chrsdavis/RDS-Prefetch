# rds_pass/CMakeLists.txt

add_library(RDSPrefetchPass MODULE
    rdsPrefetchPass.cpp
)

target_link_libraries(RDSPrefetchPass PRIVATE
    LLVMCore
    LLVMAnalysis
    LLVMSupport
    LLVMTransformUtils
    LLVMIRReader
    LLVMBitWriter
    LLVMBitReader
    LLVMPasses
)

set_target_properties(RDSPrefetchPass PROPERTIES
    COMPILE_FLAGS "-fno-rtti"
)

target_include_directories(RDSPrefetchPass PRIVATE ${LLVM_INCLUDE_DIRS})
