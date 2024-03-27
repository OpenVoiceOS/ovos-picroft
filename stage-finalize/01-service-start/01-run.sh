#/bin/bash -e

install -v -m 0644 files/ovos-ggwave-listener.service "${ROOTFS_DIR}/etc/systemd/user/ovos-ggwave-listener.service"
echo "enable ovos-ggwave-listener.service" >> "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
