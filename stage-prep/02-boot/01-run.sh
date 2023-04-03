#!/bin/bash -e

set -exu

# console auto login
sed -i "s|\bovos\b|${FIRST_USER_NAME}|g" files/autologin.conf
install -v -m 0644 files/autologin.conf "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/autologin.conf"

cat <<EOF >> "${ROOTFS_DIR}/boot/config.txt"

[pi0]
arm_64bit=0

[all]

EOF
