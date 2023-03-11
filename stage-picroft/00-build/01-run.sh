#!/bin/bash -e

set -exu

cat "${ROOTFS_DIR}/etc/fstab"
# create ramdisk
echo "tmpfs /ramdisk tmpfs rw,nodev,nosuid,size=20M 0 0" >> "${ROOTFS_DIR}/etc/fstab"

# console auto login
install -v -m 0644 files/etc/systemd/system/getty@tty1.service.d/autologin.conf "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/autologin.conf"

# install picroft files
install -v -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"
install -v -m 0644 files/etc/mycroft/mycroft.conf "${ROOTFS_DIR}/etc/mycroft/mycroft.conf"

# bash scripts
install -v -m 0664 files/home/ovos/.bashrc "${ROOTFS_DIR}/home/ovos/.bashrc"
install -v -m 0664 files/home/ovos/.bash_profile "${ROOTFS_DIR}/home/ovos/.bash_profile"
install -v -m 0664 files/home/ovos/cli_login.sh "${ROOTFS_DIR}/home/ovos/cli_login.sh"

# helper scripts
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/bin"

install -v -m 0755 files/home/ovos/.local/bin/bus-monitor "${ROOTFS_DIR}/home/ovos/.local/bin/bus-monitor"
install -v -m 0755 files/home/ovos/.local/bin/ovos-listen "${ROOTFS_DIR}/home/ovos/.local/bin/ovos-listen"
install -v -m 0755 files/home/ovos/.local/bin/ovos-speak "${ROOTFS_DIR}/home/ovos/.local/bin/ovos-speak"
install -v -m 0755 files/home/ovos/.local/bin/ovos-say-to "${ROOTFS_DIR}/home/ovos/.local/bin/ovos-say-to"

# systemd entrypoints
install -v -m 0755 files/home/ovos/.local/bin/mycroft-systemd-messagebus "${ROOTFS_DIR}/home/ovos/.local/bin/mycroft-systemd-messagebus"
install -v -m 0755 files/home/ovos/.local/bin/mycroft-systemd-skills "${ROOTFS_DIR}/home/ovos/.local/bin/mycroft-systemd-skills"
install -v -m 0755 files/home/ovos/.local/bin/mycroft-systemd-audio "${ROOTFS_DIR}/home/ovos/.local/bin/mycroft-systemd-audio"
install -v -m 0755 files/home/ovos/.local/bin/mycroft-systemd-voice "${ROOTFS_DIR}/home/ovos/.local/bin/mycroft-systemd-voice"
install -v -m 0755 files/home/ovos/.local/bin/mycroft-systemd-phal "${ROOTFS_DIR}/home/ovos/.local/bin/mycroft-systemd-phal"
install -v -m 0755 files/home/ovos/.local/bin/mycroft-systemd-admin-phal "${ROOTFS_DIR}/home/ovos/.local/bin/mycroft-systemd-admin-phal"

# systemd services
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.config"

install -v -m 0644 files/usr/lib/systemd/user/mycroft.service "${ROOTFS_DIR}/usr/lib/systemd/user/mycroft.service"
install -v -m 0644 files/usr/lib/systemd/user/mycroft-audio.service "${ROOTFS_DIR}/usr/lib/systemd/user/mycroft-audio.service"
install -v -m 0644 files/usr/lib/systemd/user/mycroft-messagebus.service "${ROOTFS_DIR}/usr/lib/systemd/user/mycroft-messagebus.service"
install -v -m 0644 files/usr/lib/systemd/user/mycroft-phal.service "${ROOTFS_DIR}/usr/lib/systemd/user/mycroft-phal.service"
install -v -m 0644 files/usr/lib/systemd/user/mycroft-skills.service "${ROOTFS_DIR}/usr/lib/systemd/user/mycroft-skills.service"
install -v -m 0644 files/usr/lib/systemd/user/mycroft-voice.service "${ROOTFS_DIR}/usr/lib/systemd/user/mycroft-voice.service"
install -v -m 0644 files/usr/lib/systemd/user-preset/10-ovos.preset "${ROOTFS_DIR}/usr/lib/systemd/user-preset/"
install -v -m 0644 files/usr/lib/systemd/user-preset/91-dbus.preset "${ROOTFS_DIR}/usr/lib/systemd/user-preset/"
# log directories
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state/mycroft"

# other directories
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share"
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/environment.d"
install -v -m 0644 files/usr/lib/environment.d/99-environment.conf "${ROOTFS_DIR}/usr/lib/environment.d/"

#audio
install -v -m 0644 files/etc/asound.conf "${ROOTFS_DIR}/etc/"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/pulse"
install -v -m 0644 files/etc/pulse/pulseaudio-daemon.conf "${ROOTFS_DIR}/etc/pulse/"
install -v -m 0644 files/etc/pulse/pulseaudio-system.pa "${ROOTFS_DIR}/etc/pulse/"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/dbus-1"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/dbus-1/system.d"
install -v -m 0644 files/etc/dbus-1/system.d/ovos.conf "${ROOTFS_DIR}/etc/dbus-1/system.d/"
install -v -m 0644 files/etc/dbus-1/system.d/pulseaudio-system.conf "${ROOTFS_DIR}/etc/dbus-1/system.d/"

# mimic and vosk
cp -Rv files/home/ovos/.local/share/*

install -v -m 0755 files/home/ovos/install_ovos.sh "${ROOTFS_DIR}/home/ovos/"

# install ovos-core
on_chroot << EOF
chown -Rv ovos:ovos /home/ovos
chmod -Rv +x /home/ovos/.local/bin/*

sudo -u ovos -H -E bash -x /home/ovos/install_ovos.sh

rm -rf /home/ovos/install_ovos

EOF
