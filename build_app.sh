#!/bin/bash

set -e

readonly CUR_DIR=`pwd`
readonly SOURCE_DIR=$CUR_DIR/../app.tinywifi
readonly TARGET_DIR=$CUR_DIR/../out/app.tinywifi

function copy_files() {
	rm -rf $TARGET_DIR

	mkdir -p $TARGET_DIR
	cd $TARGET_DIR
	cp -r $SOURCE_DIR/debian_overlay    .

	# get version number + build number
	readonly VERSION_NUMBER=remw_$(cat $SOURCE_DIR/debian_overlay/root/version.txt)
	cd $SOURCE_DIR
	readonly BUILD_NUMBER=`git log --oneline | wc -l | tr -d ' '`
	echo --- version number = $VERSION_NUMBER, build number = $BUILD_NUMBER
	echo ${VERSION_NUMBER}_${BUILD_NUMBER}  >  $TARGET_DIR/debian_overlay/root/version.txt
}

function generate_deb() {
	# placeholder
	echo "--- Placeholder: to generate debian package file"
}

copy_files
generate_deb

exit 0
