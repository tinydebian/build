# Recompile with:
# mkimage -C none -A arm -T script -d boot.cmd boot.scr

setenv env_addr 0x45000000
setenv kernel_addr 0x46000000
setenv dtb_addr 0x48000000

fatload mmc 0 ${kernel_addr} Image
fatload mmc 0 ${dtb_addr} sun50i-h5-nanopi-neo2.dtb
fdt addr ${dtb_addr} 0x100000

fdt set mmc0 boot_device <1>

setenv bootargs console=ttyS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait fsck.repair=yes panic=10
booti ${kernel_addr} - ${dtb_addr}
