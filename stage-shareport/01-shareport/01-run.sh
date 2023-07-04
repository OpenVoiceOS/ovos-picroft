#!/bin/bash -e

echo "Building required nqptp service"

echo "enable nqptp" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"

echo "Building SharePort service"

echo "enable shairport-sync" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
