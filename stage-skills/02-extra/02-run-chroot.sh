if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

# ovos skills
pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-easter-eggs
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-icanhazdadjokes
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-ip@update
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-spelling
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-parrot
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-randomness

# No setup.py yet
#pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-dictation

pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-moviemaster

pip3 install git+https://github.com/femelo/skill-ovos-pyradios

deactivate
