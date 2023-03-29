#!/bin/bash -e

set -exu

#audio
install -v -d -m 0755 "${ROOTFS_DIR}/etc/pulse"
install -v -m 0644 files/pulseaudio-daemon.conf "${ROOTFS_DIR}/etc/pulse/"
install -v -m 0644 files/pulseaudio-system.pa "${ROOTFS_DIR}/etc/pulse/"

install -v -m 0644 files/asound.conf "${ROOTFS_DIR}/etc/"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev/rules.d"
install -v -m 0644 files/91-pulseaudio-GeneralPlus.rules "${ROOTFS_DIR}/etc/udev/rules.d/"

on_chroot <<EOF

# Install ncpamixer

git clone https://github.com/fulhax/ncpamixer.git
cd ncpamixer
make
make install
cd ..
rm -rf ncpamixer

EOF
