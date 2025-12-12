add_library(RDSPrefetchPass MODULE
    rdsPrefetchPass.cpp
)

target_compile_features(RDSPrefetchPass PRIVATE cxx_range_for cxx_auto_type)
set_target_properties(RDSPrefetchPass PROPERTIES
    COMPILE_FLAGS "-fno-rtti"
)
