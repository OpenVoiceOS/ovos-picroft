#!/bin/bash -e

install -v -m 0644 files/mycroft-shell.service "${ROOTFS_DIR}/etc/systemd/user/mycroft-shell.service"
install -v -m 0644 files/mycroft-gui.service "${ROOTFS_DIR}/etc/systemd/user/mycroft-gui.service"
install -v -m 0644 files/kdeconnect.service "${ROOTFS_DIR}/etc/systemd/user/kdeconnect.service"
install -v -m 0755 files/mycroft-systemd-gui "${ROOTFS_DIR}/usr/libexec/mycroft-systemd-gui"

echo "gpu_mem=256" >> "${ROOTFS_DIR}/boot/firmware/config.txt"

echo "enable mycroft-shell.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
echo "enable mycroft-gui.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"

echo "enable kdeconnect.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
