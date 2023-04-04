#!/bin/bash -e

set -exu

# This section is needed to allow for pip user installation
on_chroot <<EOF

chown -Rv ${FIRST_USER_NAME}:${FIRST_USER_NAME} /home/${FIRST_USER_NAME}
if [ -d /home/${FIRST_USER_NAME}/.local/bin ]; then
    chmod -Rv +x /home/${FIRST_USER_NAME}/.local/bin
fi

EOF

install -v -d -m 0755 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.config/mycroft/skills"
install -v -m 0644 files/skills-ovos.txt "${ROOTFS_DIR}/"
install -v -m 0644 files/skills-neon.txt "${ROOTFS_DIR}/"
install -v -m 0644 files/skills-jarbas.txt "${ROOTFS_DIR}/"

on_chroot <<EOF

su --login ${FIRST_USER_NAME}

pip install -r /skills-ovos.txt
pip install -r /skills-neon.txt
pip install -r /skills-jarbas.txt

exit

EOF

rm "${ROOTFS_DIR}/skills-ovos.txt"
rm "${ROOTFS_DIR}/skills-neon.txt"
rm "${ROOTFS_DIR}/skills-jarbas.txt"

install -v -d -m 0755 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local"
install -v -d -m 0755 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share"
install -v -d -m 0755 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share/mycroft"
install -v -d -m 0755 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share/mycroft/skills"

cd "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share/mycroft/skills"
git clone https://github.com/andlo/fairytalez-skill.git
git clone https://github.com/forslund/skill-cocktail.git
git clone https://github.com/JarbasSkills/skill-confucius-quotes.git
