#!/bin/bash -e

set -exu

# create ramdisk
echo "tmpfs /ramdisk tmpfs rw,nodev,nosuid,size=20M 0 0" >> "${ROOTFS_DIR}/etc/fstab"

# console auto login
install -v -m 0644 files/etc/systemd/system/getty@tty1.service.d/autologin.conf "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/autologin.conf"

# install picroft files
install -v -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"
install -v -m 0644 files/etc/mycroft/mycroft.conf "${ROOTFS_DIR}/etc/mycroft/mycroft.conf"

install -v -m 0644 files/home/pi/update_all.sh "${ROOTFS_DIR}/home/pi/update_all.sh"
install -v -m 0644 files/home/pi/update_ocp.sh "${ROOTFS_DIR}/home/pi/update_ovos.sh"
install -v -m 0644 files/home/pi/update_ocp.sh "${ROOTFS_DIR}/home/pi/update_phal.sh"
install -v -m 0644 files/home/pi/update_ocp.sh "${ROOTFS_DIR}/home/pi/update_ocp.sh"
install -v -m 0644 files/home/pi/update_skills.sh "${ROOTFS_DIR}/home/pi/update_skills.sh"

# helper scripts
install -v -d -m 0755 "${ROOTFS_DIR}/home/pi/.local"
install -v -d -m 0755 "${ROOTFS_DIR}/home/pi/.local/bin"
install -v -m 0755 files/home/pi/.local/bin/bus-monitor "${ROOTFS_DIR}/home/pi/.local/bin/bus-monitor"
install -v -m 0755 files/home/pi/.local/bin/ovos-listen "${ROOTFS_DIR}/home/pi/.local/bin/ovos-listen"
install -v -m 0755 files/home/pi/.local/bin/ovos-speak "${ROOTFS_DIR}/home/pi/.local/bin/ovos-speak"
install -v -m 0755 files/home/pi/.local/bin/ovos-say-to "${ROOTFS_DIR}/home/pi/.local/bin/ovos-say-to"

# systemd entrypoints
install -v -m 0755 files/home/pi/.local/bin/mycroft-systemd-messagebus "${ROOTFS_DIR}/home/pi/.local/bin/mycroft-systemd-messagebus"
install -v -m 0755 files/home/pi/.local/bin/mycroft-systemd-skills "${ROOTFS_DIR}/home/pi/.local/bin/mycroft-systemd-skills"
install -v -m 0755 files/home/pi/.local/bin/mycroft-systemd-audio "${ROOTFS_DIR}/home/pi/.local/bin/mycroft-systemd-audio"
install -v -m 0755 files/home/pi/.local/bin/mycroft-systemd-voice "${ROOTFS_DIR}/home/pi/.local/bin/mycroft-systemd-voice"
install -v -m 0755 files/home/pi/.local/bin/mycroft-systemd-phal "${ROOTFS_DIR}/home/pi/.local/bin/mycroft-systemd-phal"
install -v -m 0755 files/home/pi/.local/bin/mycroft-systemd-admin-phal "${ROOTFS_DIR}/home/pi/.local/bin/mycroft-systemd-admin-phal"

# systemd services
install -v -d -m 0755 "${ROOTFS_DIR}/home/pi/.config"
install -v -d -m 0755 "${ROOTFS_DIR}/home/pi/.config/systemd"
install -v -d -m 0755 "${ROOTFS_DIR}/home/pi/.config/systemd/user"
install -v -m 0755 files/home/pi/.config/systemd/user/mycroft.service "${ROOTFS_DIR}/home/pi/.config/systemd/user/mycroft.service"
install -v -m 0755 files/home/pi/.config/systemd/user/mycroft-audio.service "${ROOTFS_DIR}/home/pi/.config/systemd/user/mycroft-audio.service"
install -v -m 0755 files/home/pi/.config/systemd/user/mycroft-messagebus.service "${ROOTFS_DIR}/home/pi/.config/systemd/user/mycroft-messagebus.service"
install -v -m 0755 files/home/pi/.config/systemd/user/mycroft-phal.service "${ROOTFS_DIR}/home/pi/.config/systemd/user/mycroft-phal.service"
install -v -m 0755 files/home/pi/.config/systemd/user/mycroft-skills.service "${ROOTFS_DIR}/home/pi/.config/systemd/user/mycroft-skills.service"
install -v -m 0755 files/home/pi/.config/systemd/user/mycroft-voice.service "${ROOTFS_DIR}/home/pi/.config/systemd/user/mycroft-voice.service"

# install ovos-core
on_chroot << EOF
chown -Rv pi:pi /home/pi
chmod -Rv +x /home/pi/*.sh

sudo -u pi -E bash -x /home/pi/update_all.sh
EOF
