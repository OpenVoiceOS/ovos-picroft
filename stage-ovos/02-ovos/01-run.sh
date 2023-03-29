#!/bin/bash -e

set -exu

install -v -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"
install -v -m 0644 files/mycroft.conf "${ROOTFS_DIR}/etc/mycroft/mycroft.conf"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/bin"
install -v -m 0755 files/bus-monitor "${ROOTFS_DIR}/home/ovos/.local/bin/bus-monitor"

# log directories
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state/mycroft"

pip install -r files/core.txt
pip install -r files/ocp.txt
pip install -r files/phal.txt
pip install -r files/speech.txt
pip install -r files/voice.txt
