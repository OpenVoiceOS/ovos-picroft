#/bin/bash -e

install -v -m 0644 files/ovos-ggwave-listener.service "${ROOTFS_DIR}/etc/systemd/user/ovos-ggwave-listener.service"

# This still is not working well when running for long term

# echo "enable ovos-ggwave-listener.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/bin"
