#/bin/bash -e

# rm "${ROOTFS_DIR}/usr/libexec/init_resize"
# install -v -m 0755 files/init_resize "${ROOTFS_DIR}/usr/libexec/init_resize"
# install -v -m 0755 files/resize_fs.sh "${ROOTFS_DIR}/usr/libexec/resize_fs.sh"
# install -v -m 0644 files/resize_fs.service "${ROOTFS_DIR}/etc/systemd/system/resize_fs.service"
#
# install -v -d -m 0755 "${ROOTFS_DIR}/opt/ovos"
# touch "${ROOTFS_DIR}/opt/ovos/resize_fs"
#
# echo "enable resize_fs.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
