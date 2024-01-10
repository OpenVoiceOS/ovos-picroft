if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

# ovos skills
pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-easter-eggs
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-dictation@tests
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-icanhazdadjokes
pip3 install git+https://github.com/OpenVoiceOS/skill-ip@update
pip3 install git+https://github.com/OpenVoiceOS/skill-spelling
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-parrot

deactivate
