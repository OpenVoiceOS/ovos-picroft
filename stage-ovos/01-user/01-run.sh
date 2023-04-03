#!/bin/bash -e

set -exu

# Hack for the snake of a thing called systemd
install -v -m 0644 files/first_boot "${ROOTFS_DIR}/"
on_chroot <<EOF

chown ${FIRST_USER_NAME}:${FIRST_USER_NAME} /first_boot

EOF

install -v -m 0644 files/.bashrc "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc"
sed -i "s|/home/ovos|/home/$FIRST_USER_NAME|g" files/.bash_profile
install -v -m 0644 files/.bash_profile "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bash_profile"
install -v -m 0644 files/.cli_login.sh "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.cli_login.sh"

# user level mycroft.conf
install -v -d -m 0755 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.config"
install -v -d -m 0755 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.config/mycroft"
install -v -m 0644 files/mycroft.conf "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.config/mycroft/"

# other directories
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/environment.d"
install -v -m 0644 files/99-environment.conf "${ROOTFS_DIR}/usr/lib/environment.d/"

on_chroot <<EOF

if [ -f /etc/environment ]; then
    ln -s "/etc/environment ${ROOTFS_DIR}/usr/lib/environment.d/environment"
fi

EOF
