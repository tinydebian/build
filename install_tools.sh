#!/bin/bash

set -e

readonly CUR_DIR=`pwd`
readonly TOOLCHAIN_DIR=$CUR_DIR/../toolchain

readonly TOOLCHAIN=gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu
readonly TOOLCHAIN_URL="https://releases.linaro.org/components/toolchain/binaries/7.3-2018.05/aarch64-linux-gnu/$TOOLCHAIN.tar.xz"

# install tools to build u-boot and kernel
sudo apt install -y bc bison flex swig u-boot-tools device-tree-compiler
sudo apt install -y python-dev python3-dev libssl-dev

# install tools to bootstrap debian
sudo apt install -y debootstrap qemu-user-static binfmt-support debian-archive-keyring

# install tools to generate bootable sdcard image
sudo apt install -y parted

# download gcc cross-compiler
if [ ! -d "$TOOLCHAIN_DIR/$TOOLCHAIN" ]; then
	mkdir -p $TOOLCHAIN_DIR
	cd $TOOLCHAIN_DIR
	wget $TOOLCHAIN_URL
	tar -xJf $TOOLCHAIN.tar.xz
fi

exit 0
