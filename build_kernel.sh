#!/bin/bash

# Preparation:
# Run ./install_tools to install tools.
# - gcc cross-compiler (e.g. aarch64 cross-compiler).

set -e

readonly CUR_DIR=`pwd`
readonly SOURCE_DIR=$CUR_DIR/../kernel
readonly TARGET_DIR=$CUR_DIR/../out/kernel

readonly BUILD_CPUS=`getconf _NPROCESSORS_ONLN`

function check_toolchain() {
	local TOOLCHAIN_DIR=$CUR_DIR/../toolchain
	local TOOLCHAIN=gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu

	if [ ! -d "$TOOLCHAIN_DIR/$TOOLCHAIN" ]; then
		echo "!!! Please run ./install_tools to install cross-compiler first. !!!"
		exit 1
	fi

	# add gcc cross-compiler into PATH
	export PATH=$TOOLCHAIN_DIR/$TOOLCHAIN/bin:$PATH
	echo "--- PATH = $PATH"
	echo
}

function build_kernel() {
	cd $SOURCE_DIR

	touch .scmversion
	make defconfig ARCH=arm64
	make Image     ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$BUILD_CPUS
	make dtbs      ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$BUILD_CPUS

	make modules         ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$BUILD_CPUS
	make modules_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=out_modules/ -j$BUILD_CPUS
}

function copy_kernel_files() {
	cd $SOURCE_DIR

	rm -rf $TARGET_DIR
	mkdir -p $TARGET_DIR
	cp arch/arm64/boot/Image $TARGET_DIR
	cp arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dtb $TARGET_DIR

	cp -a out_modules/lib/ $TARGET_DIR
}

check_toolchain
build_kernel
copy_kernel_files

exit 0
