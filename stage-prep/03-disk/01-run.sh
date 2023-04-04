#!/bin/bash -e

set -exu

# create ramdisk
echo "tmpfs /ramdisk tmpfs rw,nodev,nosuid,size=20M 0 0" >> "${ROOTFS_DIR}/etc/fstab"

# TODO: Setup swapfile https://github.com/NeonGeckoCom/neon_debos/tree/main/overlays/99-create-swap
# NOTE: Raspbian / Pi-Gen creates a swapfile be default.  Will look more into that
