#!/bin/bash -e

install -v -m 0644 files/91-vocalfusion.rules "${ROOTFS_DIR}/etc/udev/rules.d/91-vocalfusion.rules"
install -v -m 0644 files/99-gpio.rules "${ROOTFS_DIR}/etc/udev/rules.d/99-gpio.rules"

install -v -m 0644 files/poweroff.sh "${ROOTFS_DIR}/usr/libexec/poweroff.sh"
install -v -m 0644 files/configure_sj201_on_boot.sh "${ROOTFS_DIR}/usr/libexec/configure_sj201_on_boot.sh"
install -v -m 0644 files/shutdown_sj201.sh "${ROOTFS_DIR}/usr/libexec/shutdown_sj201.sh"
install -v -m 0644 files/one_time_sj201.sh "${ROOTFS_DIR}/usr/libexec/one_time_sj201.sh"
install -v -m 0644 files/xvf3510-flash "${ROOTFS_DIR}/usr/libexec/xvf3510-flash"

install -v -m 0644 files/xvf3510.dtbo "${ROOTFS_DIR}/boot/firmware/xvf3510.dtbo"

install -v -m 0644 files/poweroff.service "${ROOTFS_DIR}/etc/systemd/system/poweroff.service"
install -v -m 0644 files/sj201-shutdown.service "${ROOTFS_DIR}/etc/systemd/system/sj201-shutdown.service"
install -v -m 0644 files/sj201.service "${ROOTFS_DIR}/etc/systemd/system/sj201.service"

if [[ -f "${ROOTFS_DIR}/etc/pulse/default.pa" || -L "${ROOTFS_DIR}/etc/pulse/default.pa" ]] ; then
echo "removing existing default.pa"
rm "${ROOTFS_DIR}/etc/pulse/default.pa"
fi
if [[ -f "${ROOTFS_DIR}/etc/pulse/daemon.conf" || -L "${ROOTFS_DIR}/etc/pulse/daemon.conf" ]] ; then
echo "removing existing daemon.conf"
rm "${ROOTFS_DIR}/etc/pulse/daemon.conf"
fi

install -v -m 0644 files/ovos-sj201-daemon.conf "${ROOTFS_DIR}/etc/pulse/ovos-sj201-daemon.conf"
ln -s "${ROOTFS_DIR}/etc/pulse/ovos-sj201-daemon.conf" "${ROOTFS_DIR}/etc/pulse/default.conf"
install -v -m 0644 files/ovos-sj201-default.pa "${ROOTFS_DIR}/etc/pulse/ovos-sj201-default.pa"
ln -s "${ROOTFS_DIR}/etc/pulse/ovos-sj201-default.pa" "${ROOTFS_DIR}/etc/pulse/default.pa"

if [[ -f "${ROOTFS_DIR}/etc/asound.conf" ]]; then
rm "${ROOTFS_DIR}/etc/asound.conf"
fi
install -v -m 0644 files/asound.conf "${ROOTFS_DIR}/etc/asound.conf"

install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/firmware"
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/firmware/xvf3510"
install -v -m 0644 files/app_xvf3510_int_spi_boot_v4_1_0.bin "${ROOTFS_DIR}/usr/lib/firmware/xvf3510/app_xvf3510_int_spi_boot_v4_1_0.bin"

# sed -i "s|#dtparam=i2c_arm=on|dtparam=i2c_arm=on|g" "${ROOTFS_DIR}/boot/firmware/config.txt"
# sed -i "s|#dtparam=i2s=on|dtparam=i2s=on|g" "${ROOTFS_DIR}/boot/firmware/config.txt"
# sed -i "s|#dtparam=spi=on|dtparam=spi=on|g" "${ROOTFS_DIR}/boot/firmware/config.txt"
# sed -i "s|#dtparam=audio=on|dtparam=audio=on|g" "${ROOTFS_DIR}/boot/firmware/config.txt"

cat << EOF >> "${ROOTFS_DIR}/boot/firmware/config.txt"

dtoverlay=xvf3510
dtparam=krnbt=on

[pi4]

[all]
EOF

echo "enable poweroff.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
echo "enable sj201-shutdown.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
echo "enable sj201.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
