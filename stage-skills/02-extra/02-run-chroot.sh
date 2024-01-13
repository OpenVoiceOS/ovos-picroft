if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

# ovos skills
pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-easter-eggs
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-icanhazdadjokes
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-ip@update
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-spelling
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-parrot

deactivate
