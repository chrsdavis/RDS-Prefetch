FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Basic tools and build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    wget \
    curl \
    cmake \
    python3 \
    python3-pip \
    lld \
    zlib1g-dev \
    ca-certificates \
    ninja-build \
    vim \
    && rm -rf /var/lib/apt/lists/*


# Optional: Python packages for analysis scripts
RUN pip3 install --no-cache-dir numpy pandas matplotlib

WORKDIR /opt

# Get LLVM 20.1.8 source (same as assignment recommendation)
RUN git clone --depth 1 --branch llvmorg-20.1.8 https://github.com/llvm/llvm-project.git

WORKDIR /opt/llvm-project

# Configure LLVM + Clang build with Ninja (out-of-tree build in ./build)
RUN cmake \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_USE_LINKER=lld \
    -G "Ninja" \
    -S llvm \
    -B build

# Build and install LLVM/Clang with ninja
RUN ninja -C build install -j"$(nproc)"

# Default workspace where you can mount your project
WORKDIR /work

CMD ["/bin/bash"]
