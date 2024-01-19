if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-alsa
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-balena-wifi@modernize-imports
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-wifi-setup

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-system
pip3 install git+https://github.com/OpenVoiceOS/ovos_utils

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-ipgeo
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-connectivity-events

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-respeaker-2mic
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-respeaker-4mic

deactivate
