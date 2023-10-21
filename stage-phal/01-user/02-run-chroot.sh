if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos-phal

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-alsa
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-balena-wifi
pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-wifi-setup

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-ipgeo

deactivate
