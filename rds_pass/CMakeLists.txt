add_llvm_pass_plugin(RDSPrefetchPass
  rdsPrefetchPass.cpp
)

target_compile_features(RDSPrefetchPass PRIVATE cxx_range_for cxx_auto_type)
set_target_properties(RDSPrefetchPass PROPERTIES
    PREFIX "lib"
    SUFFIX ".so"
)

if (NOT LLVM_ENABLE_RTTI)
  target_compile_options(RDSPrefetchPass PRIVATE -fno-rtti)
endif()
