#/bin/bash -e

install -v -m 0755 files/mycroft-systemd-messagebus "${ROOTFS_DIR}/usr/libexec/mycroft-systemd-messagebus"

install -v -m 0644 files/mycroft-messagebus.service "${ROOTFS_DIR}/etc/systemd/user/mycroft-messagebus.service"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"

on_chroot << EOF
systemctl mask userconfig.service
EOF
