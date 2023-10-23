#!/bin/bash -e

install -v -m 0644 files/ovos-shell.service "${ROOTFS_DIR}/etc/systemd/user/ovos-shell.service"
install -v -m 0644 files/ovos-gui.service "${ROOTFS_DIR}/etc/systemd/user/ovos-gui.service"
install -v -m 0755 files/ovos-systemd-gui "${ROOTFS_DIR}/usr/libexec/ovos-systemd-gui"

echo "enable ovos-shell.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
echo "enable ovos-gui.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
