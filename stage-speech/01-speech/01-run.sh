#!/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/piper_tts"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/piper_tts/voice-en-gb-alan-low"

wget https://github.com/rhasspy/piper/releases/download/v0.0.2/voice-en-gb-alan-low.tar.gz -P "${ROOTFS_DIR}/home/ovos/.local/share/piper_tts/voice-en-gb-alan-low/"
on_chroot << EOF

tar -xvzf /home/ovos/.local/share/piper_tts/voice-en-gb-alan-low/voice-en-gb-alan-low.tar.gz -C /home/ovos/.local/share/piper_tts/voice-en-gb-alan-low

EOF

install -v -m 0644 files/ovos-audio.service "${ROOTFS_DIR}/etc/systemd/user/ovos-audio.service"
install -v -m 0755 files/ovos-systemd-audio "${ROOTFS_DIR}/usr/libexec/ovos-systemd-audio"

echo "enable ovos-audio.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
