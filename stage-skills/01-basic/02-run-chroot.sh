if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos_skill_installer

pip3 install git+https://github.com/openVoiceOS/skill-ovos-date-time
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-naptime
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-personal
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-volume
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-weather
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-fallback-unknown
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-wikipedia
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-wolfie
pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-alerts
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-tunein
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-somafm
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-ddg
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-youtube-music
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-news
pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-local-media

pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-boot-finished

deactivate
