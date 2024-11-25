#/bin/bash -e
rm "${ROOTFS_DIR}/home/ovos/.config/mycroft/mycroft.conf"

install -v -m 0755 "${STAGE_DIR}/../update.sh" "${ROOTFS_DIR}/home/ovos/update.sh"
# Stable image
#install -v -m 0644 files/constraints.txt "${ROOTFS_DIR}/etc/mycroft/constraints.txt"
