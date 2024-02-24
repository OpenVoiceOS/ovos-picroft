#!/bin/bash -e

# Remove old configurations
# if [[ -f "${ROOTFS_DIR}/etc/pulse/system.pa" ]] || [[ -L "${ROOTFS_DIR}/etc/pulse/system.pa" ]]; then
# rm "${ROOTFS_DIR}/etc/pulse/system.pa"
# fi
# if [[ -f "${ROOTFS_DIR}/etc/pulse/default.pa" ]] || [[ -L "${ROOTFS_DIR}/etc/pulse/default.pa" ]] ; then
# rm "${ROOTFS_DIR}/etc/pulse/default.pa"
# fi
# if [[ -f "${ROOTFS_DIR}/etc/pulse/daemon.conf" ]] || [[ -L "${ROOTFS_DIR}/etc/pulse/daemon.conf" ]] ; then
# rm "${ROOTFS_DIR}/etc/pulse/daemon.conf"
# fi
# if [[ -f "${ROOTFS_DIR}/var/lib/alsa/asound.state" ]] || [[ -L "${ROOTFS_DIR}/var/lib/alsa/asound.state" ]] ; then
# rm "${ROOTFS_DIR}/var/lib/alsa/asound.state"
# fi
# if [[ -f "${ROOTFS_DIR}/etc/ovos_asound.state" ]] || [[ -L "${ROOTFS_DIR}/etc/ovos_asound.state" ]] ; then
# rm "${ROOTFS_DIR}/etc/ovos_asound.state"
# fi

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

echo "enable pulseaudio.socket" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
echo "enable pulseaudio.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
