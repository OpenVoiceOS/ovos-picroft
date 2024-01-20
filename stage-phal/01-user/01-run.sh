#!/bin/bash -e

install -v -m 0755 files/mycroft-systemd-phal "${ROOTFS_DIR}/usr/libexec/mycroft-systemd-phal"
install -v -m 0644 files/mycroft-phal.service "${ROOTFS_DIR}/etc/systemd/user/mycroft-phal.service"

echo "enable mycroft-phal.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"

