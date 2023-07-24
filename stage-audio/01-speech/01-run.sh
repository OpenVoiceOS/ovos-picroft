#!/bin/bash -e

#audio
install -v -d -m 0755 "${ROOTFS_DIR}/etc/pulse"
install -v -m 0644 files/pulseaudio-daemon.conf "${ROOTFS_DIR}/etc/pulse/"
install -v -m 0644 files/pulseaudio-system.pa "${ROOTFS_DIR}/etc/pulse/"

# Comment out `suspend_on_idle` from both system.pa and default.pa
sed -i "s\load-module module-suspend-on-idle\#load-module module-suspend-on-idle\g" ${ROOTFS_DIR}/etc/pulse/default.pa
sed -i "s\load-module module-suspend-on-idle\#load-module module-suspend-on-idle\g" ${ROOTFS_DIR}/etc/pulse/system.pa
sed -i "s\load-module module-udev-detect\load-module module-udev-detect tsched=0\g" ${ROOTFS_DIR}/etc/pulse/system.pa

install -v -m 0644 files/asound.conf "${ROOTFS_DIR}/etc/asound.conf"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev/rules.d"
install -v -m 0644 files/91-pulseaudio-GeneralPlus.rules "${ROOTFS_DIR}/etc/udev/rules.d/"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/piper_tts"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/piper_tts/voice-en-gb-alan-low"

wget https://github.com/rhasspy/piper/releases/download/v0.0.2/voice-en-gb-alan-low.tar.gz
mv voice-en-gb-alan-low.tar.gz "${ROOTFS_DIR}/home/ovos/.local/share/piper_tts/voice-en-gb-alan-low/"
tar -xf "${ROOTFS_DIR}/home/ovos/.local/share/piper_tts/voice-en-gb-alan-low/voice-en-gb-alan-low.tar.gz"

install -v -m 0644 files/ovos-audio.service "${ROOTFS_DIR}/etc/systemd/user/ovos-audio.service"
install -v -m 0755 files/ovos-systemd-audio "${ROOTFS_DIR}/usr/libexec/ovos-systemd-audio"

echo "enable ovos-audio.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
