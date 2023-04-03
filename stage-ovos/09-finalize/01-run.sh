#!/bin/bash -e

set -exu

ls "${ROOTFS_DIR}/"
# Make sure permissions for home folder are good,
# and files in ~/.local/bin are executable

on_chroot <<EOF

chown -Rv ovos:ovos "/home/${FIRST_USER_NAME}"
chmod -Rv +x "/home/${FIRST_USER_NAME}/.local/bin"

su -c 'systemctl --user enable ovos.service' --login ovos
su -c 'systemctl --user enable ovos-messagebus.service' --login ovos
su -c 'systemctl --user enable ovos-audio.service' --login ovos
su -c 'systemctl --user enable ovos-voice.service' --login ovos
su -c 'systemctl --user enable ovos-phal.service' --login ovos
su -c 'systemctl --user enable ovos-skills.service' --login ovos

systemctl enable ovos-admin-phal.service

systemctl enable NetworkManager

EOF

ARCHIVE_FILENAME="raspbian-ovos-dev"
