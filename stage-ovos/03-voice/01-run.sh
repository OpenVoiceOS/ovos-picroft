#!/bin/bash -e

set -exu

# TODO: Add more preloaded ww

install -v -d -m 0755 "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.local/share"
install -v -d -m 0755 "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.local/share/precise-lite"
install -v -m 0644 files/hey_mycroft.tflite "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.local/share/precise-lite/"

install -v -d -m 0755 "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.local/share/vosk"
cp -rv files/vosk/* "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.local/share/vosk/"

install -v -d -m 0755 "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.local/share/openwakeword"
install -v -m 0644 files/hey_mycroft_v0.1.onnx "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.local/share/openwakeword/"
