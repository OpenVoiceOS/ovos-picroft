#!/bin/bash -e

set -exu

# systemd entrypoints
install -v -d -m 0755 "${ROOTFS_DIR}/usr/libexec"
install -v -m 0755 files/ovos-systemd-messagebus "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/ovos-systemd-skills "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/ovos-systemd-audio "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/ovos-systemd-voice "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/ovos-systemd-phal "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/ovos-systemd-admin-phal "${ROOTFS_DIR}/usr/libexec/"

# system services
install -v -m 0644 files/ovos-admin-phal.service "${ROOTFS_DIR}/etc/systemd/system/ovos-admin-phal.service"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/systemd/system-preset"
install -v -m 0644 files/10-ovos.preset.system "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos.preset"

# user services
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/systemd/user"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/systemd/user/ovos.service.wants"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/systemd/user-preset"
install -v -m 0644 files/10-ovos.preset "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos.preset"

install -v -m 0644 files/ovos.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos.service"
install -v -m 0644 files/ovos-audio.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-audio.service"
install -v -m 0644 files/ovos-messagebus.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-messagebus.service"
install -v -m 0644 files/ovos-phal.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-phal.service"
install -v -m 0644 files/ovos-skills.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-skills.service"
install -v -m 0644 files/ovos-voice.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-voice.service"

install -v -d -m 0755 "${ROOTFS_DIR}/var/lib/systemd/linger"
touch "${ROOTFS_DIR}/var/lib/systemd/linger/${FIRST_USER_NAME}"

# balena stuff
install -v -m 0755 files/wifi-connect.bin "${ROOTFS_DIR}/usr/local/sbin/wifi-connect"
cp -rv files/wifi-connect "${ROOTFS_DIR}/usr/local/share/"

on_chroot <<EOF

chmod -R a+r /usr/local/share/wifi-connect

EOF
