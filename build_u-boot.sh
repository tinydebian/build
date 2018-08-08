#!/bin/bash

# Preparation:
# Run ./install_tools to install tools.
# - gcc cross-compiler (e.g. aarch64 cross-compiler).
# - bison flex swig u-boot-tools device-tree-compiler.

set -e

readonly CUR_DIR=`pwd`
readonly SOURCE_DIR=$CUR_DIR/../u-boot
readonly TARGET_DIR=$CUR_DIR/../out/u-boot

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

function build_u-boot() {
	cd $SOURCE_DIR
	make nanopi_neo2_defconfig
	make CROSS_COMPILE=aarch64-linux-gnu- -j$BUILD_CPUS

	cd $CUR_DIR/misc
	mkimage -C none -A arm -T script -d boot.cmd boot.scr
}

function copy_u-boot_files() {
	mkdir -p $TARGET_DIR

	cd $SOURCE_DIR
	cp spl/sunxi-spl.bin $TARGET_DIR
	cp u-boot.itb $TARGET_DIR

	cp $CUR_DIR/misc/boot.scr $TARGET_DIR
}

check_toolchain
build_u-boot
copy_u-boot_files

exit 0
