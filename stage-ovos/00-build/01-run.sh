#!/bin/bash -e

set -exu

# create ramdisk
echo "tmpfs /ramdisk tmpfs rw,nodev,nosuid,size=20M 0 0" >> "${ROOTFS_DIR}/etc/fstab"

# console auto login
install -v -m 0644 files/etc/systemd/system/getty@tty1.service.d/autologin.conf "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/autologin.conf"

# install ovos files
install -v -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"
install -v -m 0644 files/etc/mycroft/mycroft.conf "${ROOTFS_DIR}/etc/mycroft/mycroft.conf"

#audio
install -v -d -m 0755 "${ROOTFS_DIR}/etc/pulse"
install -v -m 0644 files/etc/pulse/pulseaudio-daemon.conf "${ROOTFS_DIR}/etc/pulse/"
install -v -m 0644 files/etc/pulse/pulseaudio-system.pa "${ROOTFS_DIR}/etc/pulse/"

install -v -m 0644 files/etc/asound.conf "${ROOTFS_DIR}/etc/"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/udev/rules.d"
install -v -m 0644 files/etc/udev/rules.d/91-pulseaudio-GeneralPlus.rules "${ROOTFS_DIR}/etc/udev/rules.d/"

# locale
install -v -d -m 0755 "${ROOTFS_DIR}/etc/wpa_supplicant"
install -v -m 0600 files/etc/wpa_supplicant/wpa_supplicant.conf "${ROOTFS_DIR}/boot"

# home directory

# bash scripts
install -v -m 0664 files/home/ovos/.bashrc "${ROOTFS_DIR}/home/ovos/.bashrc"
install -v -m 0664 files/home/ovos/.bash_profile "${ROOTFS_DIR}/home/ovos/.bash_profile"
install -v -m 0664 files/home/ovos/.cli_login.sh "${ROOTFS_DIR}/home/ovos/.cli_login.sh"

# user level mycroft.conf
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.config"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.config/mycroft"
install -v -m 0644 files/home/ovos/.config/mycroft/mycroft.conf "${ROOTFS_DIR}/home/ovos/.config/mycroft/"

# helper scripts
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/bin"

install -v -m 0755 files/home/ovos/.local/bin/bus-monitor "${ROOTFS_DIR}/home/ovos/.local/bin/bus-monitor"

# log directories
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state/mycroft"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/precise-lite"
install -v -m 0644 files/home/ovos/.local/share/precise-lite/hey_mycroft.tflite "${ROOTFS_DIR}/home/ovos/.local/share/precise-lite/"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/share/vosk"
cp -rv files/home/ovos/.local/share/vosk/* "${ROOTFS_DIR}/home/ovos/.local/share/vosk/"

# /usr

# systemd entrypoints
install -v -d -m 0755 "${ROOTFS_DIR}/usr/libexec"
install -v -m 0755 files/usr/libexec/ovos-systemd-messagebus "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/usr/libexec/ovos-systemd-skills "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/usr/libexec/ovos-systemd-audio "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/usr/libexec/ovos-systemd-voice "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/usr/libexec/ovos-systemd-phal "${ROOTFS_DIR}/usr/libexec/"
install -v -m 0755 files/usr/libexec/ovos-systemd-admin-phal "${ROOTFS_DIR}/usr/libexec/"

# system services
install -v -m 0644 files/usr/lib/systemd/system/ovos-admin-phal.service "${ROOTFS_DIR}/usr/lib/systemd/system/"
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/systemd/system-preset"
install -v -m 0644 files/usr/lib/systemd/system-preset/10-ovos.conf "${ROOTFS_DIR}/usr/lib/systemd/system-preset/"

# user services
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/systemd/user/default.target.wants"
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/systemd/user/ovos.service.wants"

install -v -m 0644 files/usr/lib/systemd/user/ovos.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-audio.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-audio.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-messagebus.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-messagebus.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-phal.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-phal.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-skills.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-skills.service"
install -v -m 0644 files/usr/lib/systemd/user/ovos-voice.service "${ROOTFS_DIR}/usr/lib/systemd/user/ovos-voice.service"

install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/systemd/user-preset"
install -v -m 0644 files/usr/lib/systemd/user-preset/10-ovos.preset "${ROOTFS_DIR}/usr/lib/systemd/user-preset/"

# other directories
install -v -d -m 0755 "${ROOTFS_DIR}/usr/lib/environment.d"
install -v -m 0644 files/usr/lib/environment.d/99-environment.conf "${ROOTFS_DIR}/usr/lib/environment.d/"

# balena stuff
install -v -m 0755 files/usr/local/sbin/wifi-connect "${ROOTFS_DIR}/usr/local/sbin/"
cp -rv files/usr/local/share/wifi-connect "${ROOTFS_DIR}/usr/local/share/"

install -v -m 0755 files/install_ovos.sh "${ROOTFS_DIR}/"
install -v -m 0755 files/install_skills.sh "${ROOTFS_DIR}/"

# try enabling ssh from here
touch "${ROOTFS_DIR}/boot/ssh"

# install ovos-core
on_chroot << EOF

ssh-keygen -A && update-rc.d ssh enable

chmod -v +x /install_ovos.sh
chmod -v +x /install_skills.sh

chown -Rv ovos:ovos /home/ovos
chmod -Rv +x /home/ovos/.local/bin/*

sudo -E bash -x /install_ovos.sh

sudo -u ovos -H -E bash -x /install_skills.sh

sudo rm /install_ovos.sh
sudo rm /install_skills.sh

EOF
