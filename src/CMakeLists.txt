# src/CMakeLists.txt

set(RPREFETCH_SOURCES
    PrefetchPass.cpp
    Analysis.cpp
)

# Creates a shared library like libRecursivePrefetch.so / .dylib / .dll
add_llvm_pass_plugin(RecursivePrefetch
    ${RPREFETCH_SOURCES}

    # If LLVM components (Core, ScalarOpts, etc.) are needed,
    # then put them here:
    LINK_COMPONENTS
      Core
      Analysis
      TransformUtils
      ScalarOpts
      Support
)

### Alternatively, we can just make it a library then link it to the plugin
### Idk what would be better tbh; don't know enough about LLVM
# add_library(RecursivePrefetchCore STATIC ${RPREFETCH_SOURCES})
# target_link_libraries(RecursivePrefetchCore PRIVATE LLVMCore LLVMSupport ...)
# add_llvm_pass_plugin(RecursivePrefetch
#     Plugin.cpp
#     LINK_LIBS PRIVATE RecursivePrefetchCore
# )

target_include_directories(RecursivePrefetch
    PRIVATE
      ${PROJECT_SOURCE_DIR}/include
)
