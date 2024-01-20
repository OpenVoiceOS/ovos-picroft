#!/bin/bash -e

install -v -m 0755 files/mycroft-systemd-admin-phal "${ROOTFS_DIR}/usr/libexec/mycroft-systemd-admin-phal"
install -v -m 0644 files/mycroft-admin-phal.service "${ROOTFS_DIR}/etc/systemd/system/mycroft-admin-phal.service"

echo "enable mycroft-admin-phal.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"

