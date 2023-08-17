#!/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/hivemind"
install -v -m 0644 files/hivemind-listener.service "${ROOTFS_DIR}/etc/systemd/user/hivemind-listener.service"

echo "disable hivemind-listener.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
