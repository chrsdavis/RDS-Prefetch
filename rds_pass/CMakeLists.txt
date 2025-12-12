add_llvm_pass_plugin(RDSPrefetchPass
  rdsPrefetchPass.cpp
)

# Scripts hard-coded .so and have prefix lib
# TODO: change scripts to not care about file extension
set_target_properties(RDSPrefetchPass PROPERTIES
    PREFIX "lib"
    SUFFIX ".so"
)

if (NOT LLVM_ENABLE_RTTI)
  target_compile_options(RDSPrefetchPass PRIVATE -fno-rtti)
endif()
