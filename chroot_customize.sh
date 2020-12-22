#!/bin/sh

##############################
# we are inside chroot

set -e

install_packages() {
	apt update
	apt -y install openssh-server net-tools resolvconf
	apt -y install less zip unzip parted dosfstools usbutils
	apt -y install sudo man vim git htop bmon
	apt -y install python3
	apt -y install libnl-3-dev libnl-genl-3-dev
	apt -y install batctl
}

customize_debian() {
	# Debian9 strech: enable ssh root login
	sed -i 's/\#PermitRootLogin prohibit\-password/PermitRootLogin yes/' /etc/ssh/sshd_config
	# Debian 8 jessie: enable ssh root login
	#sed -i 's/PermitRootLogin without\-password/PermitRootLogin yes/' /etc/ssh/sshd_config

	echo tinyWiFi > /etc/hostname

	echo root:tinyDebian | chpasswd

	# misc
	echo "" >> /root/.bashrc
	echo "alias ll='ls -alF'"  >> /root/.bashrc
}

install_packages
customize_debian

# exit chroot
exit 0
