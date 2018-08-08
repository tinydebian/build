#!/bin/bash

# Preparation:
# Run this script in Ubuntu 16.04.x
# sudo apt install qemu-user-static debootstrap binfmt-support debian-archive-keyring

# Environment Variables that are needed to be configured before running this script:
# Debian_ARCH        (default: arm64, aka aarch64)
# Debian_Release     (default: stretch)
# Debian_rootfs_dir  (default: out/debian_rootfs)

# Input parameters:
# $1:
#     bootstrap: use debootstrap to create new rootfs.
#     customize: chrooot an existing rootfs to make changes.

set -e

readonly CUR_DIR=`pwd`
readonly OUT_DIR=$CUR_DIR/../out
readonly TARGET_DIR=$OUT_DIR/debian_rootfs
readonly DISTRO=stretch

show_usage() {
	echo "usage: $0 bootstrap"
	echo "       $0 customize"
}

bootstrap() {
	echo
	echo "--- Bootstrap rootfs (1st stage) ..."
	echo

	sudo rm -rf $TARGET_DIR
	sudo debootstrap --arch=arm64 --foreign $DISTRO $TARGET_DIR http://ftp.cn.debian.org/debian

	echo
	echo "--- Bootstrap rootfs (2nd stage) ..."
	echo

	# for debootstrap second_stage
	sudo cp /usr/bin/qemu-aarch64-static $TARGET_DIR/usr/bin/
	sudo LANG=C.UTF-8 LANGUAGE==C.UTF-8 LC_ALL=C.UTF-8 chroot $TARGET_DIR /debootstrap/debootstrap --second-stage --no-check-gpg http://ftp.cn.debian.org/debian
}

customize() {
	echo
	echo "--- Customize rootfs ..."
	echo

	sudo mkdir -p $TARGET_DIR/tmp/
	sudo cp chroot_customize.sh $TARGET_DIR/tmp/

	sudo LANG=C.UTF-8 LANGUAGE==C.UTF-8 LC_ALL=C.UTF-8 chroot $TARGET_DIR /tmp/chroot_customize.sh
	sudo rm -f $TARGET_DIR/tmp/chroot_customize.sh
}

parse_args_and_run() {
	if [ $# -ne 1 ]; then
		show_usage
		exit 1
	fi

	case "$1" in
		bootstrap)
			bootstrap
			;;&
		bootstrap | customize)
			customize
			;;
		*)
			show_usage
			exit 1
			;;
	esac
}

mkdir -p $OUT_DIR
parse_args_and_run $@

exit 0
