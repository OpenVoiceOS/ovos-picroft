#!/bin/bash -e

set -exu

install -v -m 0644 files/media-automount@.service "${ROOTFS_DIR}/usr/lib/systemd/system/media-automount@.service"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev/automount.d"
install -v -m 0644 files/auto "${ROOTFS_DIR}/etc/udev/automount.d/auto"
install -v -m 0644 files/hfsplus "${ROOTFS_DIR}/etc/udev/automount.d/hfsplus"
install -v -m 0644 files/ntfs "${ROOTFS_DIR}/etc/udev/automount.d/ntfs"
install -v -m 0644 files/vfat "${ROOTFS_DIR}/etc/udev/automount.d/vfat"
install -v -m 0644 files/99-media-automount.rules "${ROOTFS_DIR}/etc/udev/rules.d/99-media-automount.rules"
install -v -m 0644 files/media-automount "${ROOTFS_DIR}/usr/bin/media-automount"
install -v -d -m 0755 "${ROOTFS_DIR}/media"
