#!/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/opt/ovos"
install -v -m 0644 files/splashscreen.png "${ROOTFS_DIR}/opt/ovos/splashscreen.png"

install -v -m 0644 files/splashscreen.service "${ROOTFS_DIR}/etc/systemd/system/splashscreen.service"

echo "enable splashscreen.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
