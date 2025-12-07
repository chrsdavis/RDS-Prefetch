# benchmarks/CMakeLists.txt

# Maybe src/CMakeLists.txt defines a library target?
# (e.g., add_library(rdsprefetch ...))

# TODO: link with what we're actually building in src/

file(GLOB BENCH_SOURCES CONFIGURE_DEPENDS "*.cpp")

foreach(BENCH_SRC ${BENCH_SOURCES})
    get_filename_component(BENCH_NAME ${BENCH_SRC} NAME_WE)

    add_executable(${BENCH_NAME} ${BENCH_SRC})
    target_link_libraries(${BENCH_NAME}
        PRIVATE
            # rdsprefetch          # the pass/library from src/
            benchmark::benchmark
            benchmark::benchmark_main
    )

    target_compile_features(${BENCH_NAME} PRIVATE cxx_std_20)
endforeach()
