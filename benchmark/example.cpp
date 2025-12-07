#include <benchmark/benchmark.h>

// Example benchmark file so you guys can see the pattern

static void BM_Something(benchmark::State& state) {
    for (auto _ : state) {
        // code you want to measure
    }
}
BENCHMARK(BM_Something);

BENCHMARK_MAIN();