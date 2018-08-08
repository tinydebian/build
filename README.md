tinyDebian
==========

**tinyDebian** consists of bare minimal Bash scripts to build Debian image
from scratch. The generated image can be flashed into a Micro SD card
and boot NanoPi Neo2 arm64 board.

It is encouraged to read these Bash scripts before generating the bootable
sdcard image.

We recommend to use Ubuntu 16.04.x to build.

## How to:
0)  Install required tools:
    - sudo apt install build-essential python
    - Follow instructions in below to install (older repo for legacy Python 2 systems)
    - https://source.android.com/setup/build/downloading
1)  Use repo tool to sync the source code:
    - mkdir -p tinyDebian.source && cd tinyDebian.source
    - repo init -u https://github.com/tinydebian/manifest -b nanopi-neo2
    - repo sync -j4
    - repo forall -p -c git checkout nanopi-neo2
2)  Change to build/ sub-directory to build.
3)  Run './install_tools.sh' to install the necessary tools.
4)  Run './build_u-boot.sh' to build U-Boot.
5)  Run './build_kernel.sh' to build Linux Kernel.
6)  Run './build_debian.sh bootstrap' to bootstrap Debian image for arm64.
7)  Run './build_app.sh' to build application software.

21) (optional) Run './build_debian.sh recovery_bootstrap' to bootstrap recovery Debian image.
22) (optional) Run './build_app.recovery.sh' to build recovery application software.

31) Run './gen_images.sh' to generate bootable SD-card image.
32) Flash bootable sdcard image to Micro SD card:
    - In Windows
    - In Mac OS
    - In Linux, run command (example as below), ensure /dev/sdX is Micro SD card:
      - sudo dd if=../out/sdcard/td_x.x_yy_sdcard.img of=/dev/sdX bs=4M && sync
33) Insert Micro SD card into NanoPi Neo2 then power on to boot.

## Philosophies behind tinyDebian:
-  Simple and bare minimal Bash scripts to build Debian image from scratch.
-  Starting point to be forked for complex project.

## Why we choose NanoPi Neo2 (arm64 architecture) as our default board:
-  NanoPi Neo2 is tiny, low cost, arm64 board.

## Featured forks:

## Contact:
- www.tinydebian.com
- email: tech@tinydebian.com
