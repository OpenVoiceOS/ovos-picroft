#!/bin/bash -e

echo "enable nqptp" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"

echo "enable shairport-sync" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
