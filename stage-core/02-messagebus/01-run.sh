#/bin/bash -e

install -v -m 0755 files/ovos-systemd-messagebus "${ROOTFS_DIR}/usr/libexec/ovos-systemd-messagebus"

install -v -m 0644 files/ovos-messagebus.service "${ROOTFS_DIR}/etc/systemd/user/ovos-messagebus.service"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"

on_chroot << EOF
systemctl mask userconfig.service
EOF
