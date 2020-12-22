################################################################################
On boot, u-boot looks for file boot.scr which it will try to run.

File boot.cmd is a plaintext file that can be converted to boot.scr
by adding the required header to it using mkimage utility:

mkimage -C none -A arm -T script -d boot.cmd boot.scr
