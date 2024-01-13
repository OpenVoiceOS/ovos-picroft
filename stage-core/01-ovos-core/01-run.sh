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

install -v -m 0644 files/ovos.service "${ROOTFS_DIR}/etc/systemd/user/ovos.service"

install -v -m 0755 files/ovos-systemd-skills "${ROOTFS_DIR}/usr/libexec/ovos-systemd-skills"
install -v -m 0644 files/ovos-skills.service "${ROOTFS_DIR}/etc/systemd/user/ovos-skills.service"

echo "enable ovos-skills.service" "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
