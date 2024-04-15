#!/bin/bash -e

if [[ ! ${VIRTUAL_ENV} ]]; then
source /home/ovos/.venv/bin/activate;
fi

chown -Rf ovos:ovos /home/ovos

systemctl set-default multi-user.target

systemctl preset-all

su -c "systemctl --user preset-all" --login ovos

su -c "ln -s /ramdisk/mycroft/audio.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/bus.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/gui.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/ovos.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/ovos_shell.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/phal_admin.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/phal.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/skills.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/voice.log /home/ovos/.local/state/mycroft/" --login ovos

deactivate
