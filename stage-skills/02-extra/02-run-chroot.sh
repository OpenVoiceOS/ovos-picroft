if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

# ovos skills
pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-easter-eggs
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-dictation@tests
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-icanhazdadjokes

deactivate
