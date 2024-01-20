#!/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"
install -v -m 0644 files/mycroft.conf "${ROOTFS_DIR}/etc/mycroft/mycroft.conf"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state/mycroft"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/mycroft"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/mycroft/skills"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.config"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.config/mycroft"
install -v -m 0644 files/user-mycroft.conf "${ROOTFS_DIR}/home/ovos/.config/mycroft/mycroft.conf"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/environment.d"
install -v -m 0644 files/99-ovos-environment.conf "${ROOTFS_DIR}/etc/environment.d/99-ovos-environment.conf"

install -v -m 0644 files/mycroft.service "${ROOTFS_DIR}/etc/systemd/user/mycroft.service"

install -v -m 0755 files/mycroft-systemd-skills "${ROOTFS_DIR}/usr/libexec/mycroft-systemd-skills"
install -v -m 0644 files/mycroft-skills.service "${ROOTFS_DIR}/etc/systemd/user/mycroft-skills.service"

echo "enable mycroft-skills.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
