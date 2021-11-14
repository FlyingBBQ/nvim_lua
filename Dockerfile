FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 
ARG TARGET=nightly

RUN apt-get update && apt-get install -y \
        ninja-build \
        gettext \
        libtool \
        libtool-bin \
        autoconf \
        automake \
        cmake \
        g++ \
        pkg-config \
        unzip \
        curl \
        doxygen \
        git \
        binutils \
        && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/neovim/neovim.git /tmp/neovim && \
        cd /tmp/neovim && \
        git fetch --all --tags -f && \
        git checkout ${TARGET} && \
        make CMAKE_BUILD_TYPE=Release install
