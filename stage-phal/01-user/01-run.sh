#!/bin/bash -e

install -v -m 0755 files/ovos-systemd-phal "${ROOTFS_DIR}/usr/libexec/ovos-systemd-phal"
install -v -m 0644 files/ovos-phal.service "${ROOTFS_DIR}/etc/systemd/user/ovos-phal.service"

install -v -m 0755 files/ovos-systemd-admin-phal "${ROOTFS_DIR}/usr/libexec/ovos-systemd-admin-phal"
install -v -m 0644 files/ovos-admin-phal.service "${ROOTFS_DIR}/etc/systemd/user/ovos-admin-phal.service"

echo "enable ovos-admin-phal.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
echo "enable ovos-phal.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"

