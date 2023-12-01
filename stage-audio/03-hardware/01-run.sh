#!/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/etc/modules-load.d"
install -v -m 0644 files/i2c.conf "${ROOTFS_DIR}/etc/modules-load.d/i2c.conf"

install -v -m 0644 files/i2csound.service "${ROOTFS_DIR}/etc/systemd/system/i2csound.service"
install -v -m 0755 files/ovos-i2csound "${ROOTFS_DIR}/usr/libexec/ovos-i2csound"
install -v -m 0644 files/99-i2c.rules "${ROOTFS_DIR}/usr/lib/udev/rules.d/99-i2c.rules"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/voicecard"
install -v -m 0644 files/wm8960_asound.state "${ROOTFS_DIR}/etc/voicecard/wm8960_asound.state"
install -v -m 0644 files/ac108_asound.state "${ROOTFS_DIR}/etc/voicecard/ac108_asound.state"
install -v -m 0644 files/ac108_6mic.state "${ROOTFS_DIR}/etc/voicecard/ac108_6mic.state"

install -v -m 0644 files/xvf3510-flash "${ROOTFS_DIR}/usr/libexec/xvf3510-flash"
install -v -m 0644 files/xvf3510.dtbo "${ROOTFS_DIR}/boot/firmware/xvf3510.dtbo"
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/firmware"
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/firmware/xvf3510"
install -v -m 0644 files/app_xvf3510_int_spi_boot_v4_1_0.bin "${ROOTFS_DIR}/usr/lib/firmware/xvf3510/app_xvf3510_int_spi_boot_v4_1_0.bin"
install -v -m 0644 files/sj201-reset-led "${ROOTFS_DIR}/usr/bin/sj201-reset-led"
install -v -m 0644 files/tas5806-init "${ROOTFS_DIR}/usr/bin/tas5806-init"

install -v -m 0644 files/91-vocalfusion.rules "${ROOTFS_DIR}/etc/udev/rules.d/91-vocalfusion.rules"
install -v -m 0644 files/99-gpio.rules "${ROOTFS_DIR}/etc/udev/rules.d/99-gpio.rules"


echo "enable i2csound.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
