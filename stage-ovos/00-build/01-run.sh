#!/bin/bash -e

set -exu

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

# systemd entrypoints
install -v -m 0755 files/home/ovos/.local/bin/ovos-systemd-messagebus "${ROOTFS_DIR}/home/ovos/.local/bin/ovos-systemd-messagebus"
install -v -m 0755 files/home/ovos/.local/bin/ovos-systemd-skills "${ROOTFS_DIR}/home/ovos/.local/bin/ovos-systemd-skills"
install -v -m 0755 files/home/ovos/.local/bin/ovos-systemd-audio "${ROOTFS_DIR}/home/ovos/.local/bin/ovos-systemd-audio"
install -v -m 0755 files/home/ovos/.local/bin/ovos-systemd-voice "${ROOTFS_DIR}/home/ovos/.local/bin/ovos-systemd-voice"
install -v -m 0755 files/home/ovos/.local/bin/ovos-systemd-phal "${ROOTFS_DIR}/home/ovos/.local/bin/ovos-systemd-phal"
install -v -m 0755 files/home/ovos/.local/bin/ovos-systemd-admin-phal "${ROOTFS_DIR}/home/ovos/.local/bin/ovos-systemd-admin-phal"

# systemd services
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.config"

install -v -m 0644 files/usr/lib/systemd/user/ovos.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-audio.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-audio.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-messagebus.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-messagebus.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-phal.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-phal.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-skills.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-skills.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-voice.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-voice.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-admin-phal.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-admin-phal.service"

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

rm -rf /home/ovos/install_ovos.sh

EOF
