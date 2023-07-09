#!/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/openwakeword"

wget https://github.com/dscripka/openWakeWord/blob/main/openwakeword/resources/models/hey_mycroft_v0.1.onnx

install -v -m 0644 hey_mycroft_v0.1.onnx "${ROOTFS_DIR}/home/ovos/.local/share/openwakeword/"

rm hey_mycroft_v0.1.onnx

install -v -m 0644 files/ovos-dinkum-listener.service "${ROOTFS_DIR}/etc/systemd/user/ovos-dinkum-listener.service"
install -v -m 0755 files/ovos-systemd-dinkum-listener "${ROOTFS_DIR}/usr/libexec/ovos-systemd-dinkum-listener"

echo "enable ovos-dinkum-listener.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
