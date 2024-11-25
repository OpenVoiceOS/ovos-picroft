#!/bin/bash -e

if [[ ! ${VIRTUAL_ENV} ]]; then
source /home/ovos/.venv/bin/activate;
fi

# pip3 install ovos-tts-plugin-matxa-multispeaker-cat
# pip3 install ovos-PHAL-plugin-mk1
# pip3 install ovos-stt-plugin-citrinet

# ovos-config autoconfigure --lang ca-es --male --offline
# 
# mv /root/.config/mycroft/mycroft.conf /home/ovos/.config/mycroft/mycroft.conf

# sed -i "s|atmega328p=$(avrdude -p atmega328p -C /etc/avrdude-gpio.conf -c linuxgpio -U signature:r:-:i -F 2>/dev/null | head -n1)|#atmega328p=$(avrdude -p atmega328p -C /etc/avrdude-gpio.conf -c linuxgpio -U signature:r:-:i -F 2>/dev/null | head -n1)|" /usr/libexec/ovos-i2csound
# 
# sed -i 's|"${atmega328p}" == ":030000001E950F3B"|-e /dev/ttyAMA0|' /usr/libexec/ovos-i2csound
# # su -c "/home/ovos/.venv/bin/ovos-config autoconfigure --lang ca-es --male" --login ovos

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


# Install ovos packages
pip3 install ovos-core[lgpl,plugins,skills-audio,skills-essential,skills-internet,skills-media]
pip3 install ovos-audio[extras]
pip3 install ovos-dinkum-listener[extras,linux,onnx]
pip3 install ovos-phal[extras,linux,mk1]

pip3 install ovos-tts-plugin-matxa-multispeaker-cat

deactivate
