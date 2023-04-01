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
install -v -m 0644 files/ovos-admin-phal.service "${ROOTFS_DIR}/usr/lib/systemd/system/"

install -v -m 0644 files/ovos.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos.service"
install -v -m 0644 files/ovos-audio.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-audio.service"
install -v -m 0644 files/ovos-messagebus.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-messagebus.service"
install -v -m 0644 files/ovos-phal.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-phal.service"
install -v -m 0644 files/ovos-skills.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-skills.service"
install -v -m 0644 files/ovos-voice.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-voice.service"
install -v -d -m 0755 "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config/systemd/user"

# balena stuff
install -v -m 0755 files/wifi-connect.bin "${ROOTFS_DIR}/usr/local/sbin/wifi-connect"
cp -rv files/wifi-connect "${ROOTFS_DIR}/usr/local/share/"

# services are enabled in "stage" 02
# enable linger
on_chroot <<EOF

chmod -R a+r /usr/local/share/wifi-connect
loginctl enable-linger "$FIRST_USER_NAME"

EOF
