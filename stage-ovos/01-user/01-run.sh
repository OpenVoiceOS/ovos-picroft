#!/bin/bash -e

set -exu

# bash scripts
install -v -m 0664 files/.bashrc "${ROOTFS_DIR}/home/ovos/.bashrc"
install -v -m 0664 files/.bash_profile "${ROOTFS_DIR}/home/ovos/.bash_profile"
install -v -m 0664 files/.cli_login.sh "${ROOTFS_DIR}/home/ovos/.cli_login.sh"

# user level mycroft.conf
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.config"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.config/mycroft"
install -v -m 0644 files/mycroft.conf "${ROOTFS_DIR}/home/ovos/.config/mycroft/"

# other directories
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/environment.d"
install -v -m 0644 files/99-environment.conf "${ROOTFS_DIR}/usr/lib/environment.d/"
