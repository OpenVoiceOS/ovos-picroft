#!/bin/bash -e

install -d -v -m 0755 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share"
install -d -v -m 0755 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share/applications"
install -v -m 0644 files/ocp.desktop "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share/applications/ocp.desktop"
