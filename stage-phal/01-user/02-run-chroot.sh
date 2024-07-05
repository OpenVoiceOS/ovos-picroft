if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-alsa
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-balena-wifi
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-wifi-setup

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-system

pip3 install git+https://github.com/OpenVoiceOS/ovos_utils

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-ipgeo
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-connectivity-events

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-dotstar

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-mk1
pip3 install git+https://github.com/OpenVoiceOS/ovos-mark1-utils

pip3 install git+https://github.com/builderjer/ovos-PHAL-plugin-hotkeys@feat/autodetect

deactivate
