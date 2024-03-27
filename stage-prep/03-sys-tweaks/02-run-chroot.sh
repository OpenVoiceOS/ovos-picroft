git clone https://github.com/foundObjects/zram-swap
cd zram-swap
./install.sh
cd ..
rm -rf zram-swap

dpkg-reconfigure --frontend noninteractive locales
locale-gen

cat >> /boot/firmware/config.txt << EOF

disable_splash=1

[pi3]

force_turbo=1
boot_delay=1

[all]

dtoverlay=miniuart-bt

EOF

# echo "enable ssh.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
# echo "enable regenerate_ssh_host_keys.service" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"
#
# for GRP in input spi i2c gpio; do
# groupadd -f -r "\$GRP"
# done
# for GRP in adm dialout cdrom audio users sudo video games plugdev input gpio spi i2c netdev render; do
# adduser $FIRST_USER_NAME \$GRP
# done
#
# setupcon --force --save-only -v
# usermod --pass='*' root
# rm -f "${ROOTFS_DIR}/etc/ssh/"ssh_host_*_key*
