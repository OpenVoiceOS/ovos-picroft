if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-alsa
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-balena-wifi
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-wifi-setup

# Waiting on https://github.com/OpenVoiceOS/ovos-PHAL-plugin-system/pull/21
# pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-system
pip3 install git+https://github.com/builderjer/ovos-PHAL-plugin-system

# Waititng on https://github.com/OpenVoiceOS/ovos-utils/pull/200
# pip3 install git+https://github.com/OpenVoiceOS/ovos_utils
pip3 install git+https://github.com/builderjer/ovos_utils

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-ipgeo
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-connectivity-events

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-respeaker-2mic
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-respeaker-4mic

deactivate
