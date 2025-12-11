set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(RDSPrefetchPass MODULE
    rdsPrefetchPass.cpp
)

target_link_libraries(RDSPrefetchPass PRIVATE
    LLVMCore
    LLVMSupport
    LLVMAnalysis
    LLVMTransformUtils
    LLVMIRReader
    LLVMBitReader
)

target_compile_features(RDSPrefetchPass PRIVATE cxx_range_for cxx_auto_type)
set_target_properties(RDSPrefetchPass PROPERTIES
    COMPILE_FLAGS "-fno-rtti"
)
