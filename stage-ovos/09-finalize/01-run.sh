#!/bin/bash -e

set -exu

# Make sure permissions for home folder are good,
# and files in ~/.local/bin are executable

on_chroot <<EOF

chown -Rv ovos:ovos "/home/${FIRST_USER_NAME}"
chmod -Rv +x "/home/${FIRST_USER_NAME}/.local/bin"

systemctl preset-all
su -c 'systemctl --user preset-all' --login ovos

EOF

# This is the compressed filename without .img extention
IMG_FILENAME="raspbian-ovos-dev"
# This is the end filename without the .zip extention
ARCHIVE_FILENAME="raspbian-ovos-dev"
