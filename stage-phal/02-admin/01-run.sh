#!/bin/bash -e

install -v -m 0755 files/ovos-systemd-admin-phal "${ROOTFS_DIR}/usr/libexec/ovos-systemd-admin-phal"
install -v -m 0644 files/ovos-admin-phal.service "${ROOTFS_DIR}/etc/systemd/system/ovos-admin-phal.service"

echo "enable ovos-admin-phal.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"

