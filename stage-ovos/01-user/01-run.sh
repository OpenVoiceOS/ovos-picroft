#!/bin/bash -e

set -exu

# bash scripts
install -v -m 0644 files/.bashrc "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.bashrc"
sed -i "s/\/home\/ovos/\/home\/$FIRST_USER_NAME/g" files/.bash_profile
install -v -m 0644 files/.bash_profile "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.bash_profile"
install -v -m 0644 files/.cli_login.sh "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.cli_login.sh"

# user level mycroft.conf
install -v -d -m 0755 "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config"
install -v -d -m 0755 "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config/mycroft"
install -v -m 0644 files/mycroft.conf "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config/mycroft/"

# other directories
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/environment.d"
install -v -m 0644 files/99-environment.conf "${ROOTFS_DIR}/usr/lib/environment.d/"
