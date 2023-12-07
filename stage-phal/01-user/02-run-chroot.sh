if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

# Waiting on https://github.com/OpenVoiceOS/ovos-PHAL/pull/13
pip3 install git+https://github.com/builderjer/ovos-PHAL@feat/aiy_voicebonnet

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-alsa
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-balena-wifi
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-wifi-setup

# Waiting on https://github.com/OpenVoiceOS/ovos-PHAL-plugin-system/pull/21
pip3 install git+https://github.com/builderjer/ovos-PHAL-plugin-system
# Needs the matching ovos-utils
# Waiting on https://github.com/OpenVoiceOS/ovos-utils/pull/200
pip3 install git+https://github.com/builderjer/ovos_utils@0fb191bc038937939fefa231996ce99437d68e80

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-ipgeo
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-connectivity-events

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-respeaker-2mic
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-respeaker-4mic

deactivate
