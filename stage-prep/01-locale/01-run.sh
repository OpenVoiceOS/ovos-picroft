#!/bin/bash -e

set -exu

# locale
install -v -d -m 0755 "${ROOTFS_DIR}/etc/wpa_supplicant"
install -v -m 0600 files/wpa_supplicant.conf "${ROOTFS_DIR}/boot"
