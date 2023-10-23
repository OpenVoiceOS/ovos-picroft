#/bin/bash -e

# Enable linger
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/systemd/linger"
touch "${ROOTFS_DIR}/usr/lib/systemd/linger/ovos"
