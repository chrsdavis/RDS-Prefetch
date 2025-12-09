.PHONY: all build clean test

all: build

build:
	@mkdir -p build
	@cd build && cmake .. > /dev/null 2>&1 && make > /dev/null 2>&1

clean:
	@rm -rf build
	@rm -rf experiment_runs
	@rm -f benchmark.txt
	@rm -f experiment_results.txt

test: build
	@./build_and_benchmark.sh

experiment: build
	@rm -rf experiment_runs
	@./run_experiment.sh
