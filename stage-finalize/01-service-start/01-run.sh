#/bin/bash -e
rm "${ROOTFS_DIR}/home/ovos/.config/mycroft/mycroft.conf"

install -v -m 0644 files/mycroft.conf.ca "${ROOTFS_DIR}/home/ovos/.config/mycroft/mycroft.conf"

install -v -m 0644 files/constraints.txt "${ROOTFS_DIR}/etc/mycroft/constraints.txt"
