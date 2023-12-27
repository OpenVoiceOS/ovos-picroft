#!/bin/bash -e

# Remove old configurations
if [ -f "${ROOTFS_DIR}/etc/pulse/system.pa" ] ; then
rm "${ROOTFS_DIR}/etc/pulse/system.pa"
fi
if [ -f "${ROOTFS_DIR}/etc/pulse/default.pa" ] ; then
rm "${ROOTFS_DIR}/etc/pulse/default.pa"
fi
if [ -f "${ROOTFS_DIR}/etc/pulse/daemon.conf" ] ; then
rm "${ROOTFS_DIR}/etc/pulse/daemon.conf"
fi
if [ -f "${ROOTFS_DIR}/var/lib/alsa/asound.state" ] ; then
rm "${ROOTFS_DIR}/var/lib/alsa/asound.state"
fi
if [ -f "${ROOTFS_DIR}/etc/ovos_asound.state" ] ; then
rm "${ROOTFS_DIR}/etc/ovos_asound.state"
fi
install -v -m 0644 files/pulseaudio-daemon.conf "${ROOTFS_DIR}/etc/pulse/pulseaudio-daemon.conf"
install -v -m 0644 files/pulseaudio-system.pa "${ROOTFS_DIR}/etc/pulse/system.pa.d/pulseaudio-system.pa"
install -v -m 0644 files/default-asound.state "${ROOTFS_DIR}/var/lib/alsa/default-asound.state"

install -v -m 0644 files/asound.conf "${ROOTFS_DIR}/etc/asound.conf"

on_chroot << EOF

ln -s /var/lib/alsa/default-asound.state /etc/ovos_asound.state
ln -s /var/lib/alsa/default-asound.state /var/lib/alsa/asound.state
ln -s /etc/pulse/pulseaudio-daemon.conf /etc/pulse/daemon.conf
ln -s /etc/pulse/system.pa.d/pulseaudio-system.pa /etc/pulse/system.pa
ln -s /etc/pulse/system.pa.d/pulseaudio-system.pa /etc/pulse/default.pa

EOF

install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev/rules.d"
install -v -m 0644 files/91-pulseaudio-GeneralPlus.rules "${ROOTFS_DIR}/etc/udev/rules.d/"

install -v -m 0644 files/GeneralPlus.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/GeneralPlus.conf"

install -v -m 0644 files/seeed-voicecard-4mic-daemon.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/seeed-voicecard-4mic-daemon.conf"
install -v -m 0644 files/seeed-voicecard-4mic-default.pa "${ROOTFS_DIR}/etc/pulse/default.pa.d/seeed-voicecard-4mic-default.pa"

install -v -m 0644 files/seeed-voicecard-8mic-daemon.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/seeed-voicecard-8mic-daemon.conf"
install -v -m 0644 files/seeed-voicecard-8mic-default.pa "${ROOTFS_DIR}/etc/pulse/default.pa.d/seeed-voicecard-8mic-default.pa"

install -v -m 0644 files/sj201-daemon.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/sj201-daemon.conf"
install -v -m 0644 files/sj201-default.pa "${ROOTFS_DIR}/etc/pulse/default.pa.d/sj201-default.pa"

install -v -m 0644 files/xvf3510.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/xvf3510.conf"

install -v -m 0644 files/aiy-voicebonnet-v2.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/aiy-voicebonnet-v2.conf"

echo "enable pulseaudio.socket" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
echo "enable pulseaudio.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
