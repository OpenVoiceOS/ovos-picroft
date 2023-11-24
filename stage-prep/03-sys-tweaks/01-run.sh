#!/bin/bash -e

# Create a ramdisk
echo "tmpfs /ramdisk tmpfs rw,nodev,nosuid,size=20M 0 0" >> "${ROOTFS_DIR}/etc/fstab"

install -v -m 0644 files/97-ovos.conf "${ROOTFS_DIR}/etc/sysctl.d/97-ovos.conf"

# Autologin ovos/$FIRST_USER_NAME to cosnole
sed -i "s|\bovos\b|${FIRST_USER_NAME}|g" files/autologin.conf
install -v -m 0644 files/autologin.conf "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/autologin.conf"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/sudoers.d"

install -v -m 0644 files/ovos-sudo "${ROOTFS_DIR}/etc/sudoers.d/ovos"

install -v -m 0644 files/wifi_powersave@.service "${ROOTFS_DIR}/usr/lib/systemd/system/wifi_powersave@.service"

install -v -m 0644 files/media-automount@.service "${ROOTFS_DIR}/usr/lib/systemd/system/media-automount@.service"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev/automount.d"
install -v -m 0644 files/auto "${ROOTFS_DIR}/etc/udev/automount.d/auto"
install -v -m 0644 files/hfsplus "${ROOTFS_DIR}/etc/udev/automount.d/hfsplus"
install -v -m 0644 files/ntfs "${ROOTFS_DIR}/etc/udev/automount.d/ntfs"
install -v -m 0644 files/vfat "${ROOTFS_DIR}/etc/udev/automount.d/vfat"
install -v -m 0644 files/99-media-automount.rules "${ROOTFS_DIR}/etc/udev/rules.d/99-media-automount.rules"
install -v -m 0755 files/media-automount "${ROOTFS_DIR}/usr/bin/media-automount"
install -v -d -m 0755 "${ROOTFS_DIR}/media"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/systemd/system-preset"
install -v -m 0644 files/10-ovos-system.preset "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
install -v -m 0644 files/99-ovos-default.preset "${ROOTFS_DIR}/etc/systemd/system-preset/99-ovos-default.preset"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/systemd/user-preset"
install -v -m 0644 files/10-ovos-user.preset "${ROOTFS_DIR}/etc/systemd/user-preset/10-ovos-user.preset"
install -v -m 0644 files/99-ovos-user-default.preset "${ROOTFS_DIR}/etc/systemd/user-preset/99-ovos-user-default.preset"

install -v -d -m 0755 "${ROOTFS_DIR}/tmp/mycroft"

# Create directory for systemd hooks
install -v -d -m 0755 "${ROOTFS_DIR}/usr/libexec"

# if [[ -e "${ROOTFS_DIR}/etc/locale.gen" ]]; then
# 	rm "${ROOTFS_DIR}/etc/locale.gen"
# fi

sed -i 's/^# *\(en_US.UTF-8\)/\1/' "${ROOTFS_DIR}/etc/locale.gen"

# Enable i2c and spi
sed -i "s|#dtparam=i2c_arm=on|dtparam=i2c_arm=on|g" "${ROOTFS_DIR}/boot/firmware/config.txt"
sed -i "s|#dtparam=i2s=on|dtparam=i2s=on|g" "${ROOTFS_DIR}/boot/firmware/config.txt"
sed -i "s|#dtparam=spi=on|dtparam=spi=on|g" "${ROOTFS_DIR}/boot/firmware/config.txt"
sed -i "s|#dtparam=audio=on|dtparam=audio=on|g" "${ROOTFS_DIR}/boot/firmware/config.txt"
