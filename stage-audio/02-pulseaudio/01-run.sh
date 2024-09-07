#!/bin/bash -e

# Install a custom pulseaudio service without the socket
# install -v -m 0644 files/ovos-pulseaudio.service "${ROOTFS_DIR}/etc/systemd/user/ovos-pulseaudio.service"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/pulse/daemon.conf.d"
install -v -m 0644 files/91-pulseaudio-daemon.conf "${ROOTFS_DIR}/etc/pulse/daemon.conf.d/91-pulseaudio-daemon.conf"
install -v -m 0644 files/91-pulseaudio-system.pa "${ROOTFS_DIR}/etc/pulse/system.pa.d/91-pulseaudio-system.pa"
install -v -m 0644 files/91-pulseaudio-system.pa "${ROOTFS_DIR}/etc/pulse/default.pa.d/91-pulseaudio-default.pa"
# install -v -m 0644 files/default-asound.state "${ROOTFS_DIR}/var/lib/alsa/default-asound.state"

install -v -m 0644 files/asound.conf "${ROOTFS_DIR}/etc/asound.conf"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev/rules.d"
install -v -m 0644 files/91-pulseaudio-GeneralPlus.rules "${ROOTFS_DIR}/etc/udev/rules.d/91-pulseaudio-GeneralPlus.rules"

install -v -m 0644 files/GeneralPlus.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/GeneralPlus.conf"

echo "enable ovos-pulseaudio.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
