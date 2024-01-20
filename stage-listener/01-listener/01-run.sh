#!/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/precise_lite"

wget https://github.com/OpenVoiceOS/precise-lite-models/raw/master/wakewords/en/hey_mycroft.tflite -P "${ROOTFS_DIR}/home/ovos/.local/share/precise_lite/"

install -v -m 0644 files/mycroft-listener.service "${ROOTFS_DIR}/etc/systemd/user/mycroft-listener.service"
install -v -m 0755 files/mycroft-systemd-listener "${ROOTFS_DIR}/usr/libexec/mycroft-systemd-listener"

echo "enable mycroft-listener.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
