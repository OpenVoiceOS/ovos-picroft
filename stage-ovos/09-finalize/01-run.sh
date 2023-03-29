#!/bin/bash -e

set -exu

on_chroot <<EOF

chown -Rv ovos:ovos /home/ovos
chmod -Rv +x /home/ovos/.local/bin/*

systemctl enable NetworkManager

systemctl --user enable ovos
systemctl --user enable ovos-messagebus
systemctl --user enable ovos-audio
systemctl --user enable ovos-voice
systemctl --user enable ovos-phal
systemctl --user enable ovos-skills

systemctl enable ovos-admin-phal

systemctl set-default multi-user.target

EOF
