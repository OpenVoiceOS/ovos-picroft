#!/bin/bash -e

# NetworkManager
install -v -d -m 0755 "${ROOTFS_DIR}/etc/NetworkManager"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/NetworkManager/conf.d"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/NetworkManager/system-connections"
install -v -m 0644 files/NetworkManager.conf "${ROOTFS_DIR}/etc/NetworkManager/NetworkManager.conf"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/polkit-1"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/polkit-1/rules.d"
install -v -m 0644 files/50-org.freedesktop.NetworkManager.rules "${ROOTFS_DIR}/etc/polkit-1/rules.d/50-org.freedesktop.NetworkManager.rules"

# balena stuff
install -v -m 0755 files/wifi-connect.bin "${ROOTFS_DIR}/usr/local/sbin/wifi-connect"
cp -rv files/wifi-connect "${ROOTFS_DIR}/usr/local/share/"

on_chroot <<EOF
chmod -R a+r /usr/local/share/wifi-connect
EOF

