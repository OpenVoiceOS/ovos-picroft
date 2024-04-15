#!/bin/bash -e

# Seeed_Voicecards

install -v -d -m 0755 "${ROOTFS_DIR}/etc/modules-load.d"
install -v -m 0644 files/seeed_voicecard.conf "${ROOTFS_DIR}/etc/modules-load.d/seeed_voicecard.conf"
install -v -m 0644 files/91-seeedvoicecard.rules "${ROOTFS_DIR}/etc/udev/rules.d/91-seeedvoicecard.rules"
install -v -m 0644 files/seeed-voicecard-4mic.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/seeed-voicecard-4mic.conf"
# install -v -m 0644 files/seeed-voicecard-4mic-daemon.conf "${ROOTFS_DIR}/etc/pulse/seeed-voicecard-4mic-daemon.conf"
# install -v -m 0644 files/seeed-voicecard-4mic-default.pa "${ROOTFS_DIR}/etc/pulse/default.pa.d/seeed-voicecard-4mic-default.pa"
# install -v -m 0644 files/seeed-4mic-voicecard.dtbo "${ROOTFS_DIR}/boot/firmware/overlays/seeed-4mic-voicecard.dtbo"

install -v -m 0644 files/seeed-voicecard-8mic.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/seeed-voicecard-8mic.conf"
# install -v -m 0644 files/seeed-voicecard-8mic-daemon.conf "${ROOTFS_DIR}/etc/pulse/seeed-voicecard-8mic-daemon.conf"
# install -v -m 0644 files/seeed-voicecard-8mic-default.pa "${ROOTFS_DIR}/etc/pulse/default.pa.d/seeed-voicecard-8mic-default.pa"
# install -v -m 0644 files/seeed-8mic-voicecard.dtbo "${ROOTFS_DIR}/boot/firmware/overlays/seeed-8mic-voicecard.dtbo"

# Mark II devices

# install -v -m 0644 files/sj201-daemon.conf "${ROOTFS_DIR}/etc/pulse/daemon.conf.d/sj201-daemon.conf"
# install -v -m 0644 files/92-sj201-default.pa "${ROOTFS_DIR}/etc/pulse/default.pa.d/92-sj201-default.pa"
install -v -m 0644 files/91-vocalfusion.rules "${ROOTFS_DIR}/etc/udev/rules.d/91-vocalfusion.rules"
install -v -m 0644 files/xvf3510.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/xvf3510.conf"
install -v -m 0755 files/xvf3510-flash "${ROOTFS_DIR}/usr/libexec/xvf3510-flash"
# install -v -m 0644 files/xvf3510.dtbo "${ROOTFS_DIR}/boot/firmware/overlays/xvf3510.dtbo"
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/firmware"
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/firmware/xvf3510"
install -v -m 0644 files/app_xvf3510_int_spi_boot_v4_2_0.bin "${ROOTFS_DIR}/usr/lib/firmware/xvf3510/app_xvf3510_int_spi_boot_v4_2_0.bin"
install -v -m 0755 files/sj201-reset-led "${ROOTFS_DIR}/usr/bin/sj201-reset-led"
install -v -m 0755 files/tas5806-init "${ROOTFS_DIR}/usr/bin/tas5806-init"

# Google AIY Voicebonnet

# install -v -m 0644 files/aiy-voicebonnet-v2.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/aiy-voicebonnet-v2.conf"

install -v -m 0644 files/99-gpio.rules "${ROOTFS_DIR}/etc/udev/rules.d/99-gpio.rules"
install -v -m 0644 files/avrdude-gpio.conf "${ROOTFS_DIR}/etc/avrdude-gpio.conf"

install -v -m 0755 files/wm8960-button-overlay.dtbo "${ROOTFS_DIR}/boot/firmware/overlays/wm8960-button-overlay.dtbo"
install -v -m 0755 files/wm8960-button-overlay.dts "${ROOTFS_DIR}/boot/firmware/overlays/wm8960-button-overlay.dts"
