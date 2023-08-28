FROM ubuntu:20.04 
ARG QEMU_VERSION=8.1.0
RUN apt update && DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y  autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev \
              gawk build-essential bison flex texinfo gperf libtool patchutils bc \
              zlib1g-dev libexpat-dev pkg-config  libglib2.0-dev libpixman-1-dev libsdl2-dev \
              git tmux python3 python3-pip ninja-build && \
    apt clean

ADD https://download.qemu.org/qemu-$QEMU_VERSION.tar.xz /qemu-$QEMU_VERSION.tar.xz
RUN tar -xf /qemu-$QEMU_VERSION.tar.xz

# 进入解压后的目录
WORKDIR /qemu-$QEMU_VERSION

# 配置编译选项，并进行编译和安装
RUN ./configure  && make -j$(nproc) && make install

# 清理安装过程中的临时文件
RUN rm -rf /qemu-$QEMU_VERSION.tar.xz /qemu-$QEMU_VERSION

WORKDIR /root

