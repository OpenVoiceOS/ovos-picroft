#!/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/precise_lite"

wget https://github.com/OpenVoiceOS/precise-lite-models/raw/master/wakewords/en/hey_mycroft.tflite -P "${ROOTFS_DIR}/home/ovos/.local/share/precise_lite/"

install -v -m 0644 files/ovos-dinkum-listener.service "${ROOTFS_DIR}/etc/systemd/user/ovos-listener.service"
install -v -m 0755 files/ovos-systemd-dinkum-listener "${ROOTFS_DIR}/usr/libexec/ovos-systemd-listener"

echo "enable ovos-listener.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
