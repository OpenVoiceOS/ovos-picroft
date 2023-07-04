#!/bin/bash -e

on_chroot << EOF

curl -sL https://dtcooper.github.io/raspotify/install.sh | bash

EOF

echo "enable raspotify" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
