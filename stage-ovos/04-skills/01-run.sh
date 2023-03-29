#!/bin/bash -e

set -exu

on_chroot <<EOF
chown -Rv ovos:ovos /home/ovos
if [ -d /home/ovos/.local/bin ]; then
    chmod -Rv +x /home/ovos/.local/bin/*
fi

EOF

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.config/mycroft/skills"
install -v -m 0644 files/skills-ovos.txt "${ROOTFS_DIR}/"
install -v -m 0644 files/skills-neon.txt "${ROOTFS_DIR}/"
install -v -m 0644 files/skills-jarbas.txt "${ROOTFS_DIR}/"

on_chroot <<EOF
su -c 'pip install -r /skills-ovos.txt' ovos
su -c 'pip install -r /skills-neon.txt' ovos
su -c 'pip install -r /skills-jarbas.txt' ovos

EOF

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/mycroft"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/mycroft/skills"


cd "${ROOTFS_DIR}/home/ovos/.local/mycroft/skills"
git clone https://github.com/andlo/fairytalez-skill.git

git clone https://github.com/forslund/skill-cocktail.git

git clone https://github.com/JarbasSkills/skill-confucius-quotes.git
