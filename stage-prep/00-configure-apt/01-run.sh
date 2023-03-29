#!/bin/bash -e

set -exu

install -m 644 files/mimic.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"

cat files/mimic.gpg.key | gpg --dearmor > "${STAGE_WORK_DIR}/mimic.gpg"
install -m 644 "${STAGE_WORK_DIR}/mimic.gpg" "${ROOTFS_DIR}/etc/apt/trusted.gpg.d/"

on_chroot <<EOF

apt update

EOF
