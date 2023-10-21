if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos_skill_manager

pip3 install git+https://github.com/OpenVoiceOS/skill-alerts
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-weather
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-ddg
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-wolfie
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-wikipedia
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-news
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-somafm
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-youtube-music

# Remove some auto installed stuff
pip3 uninstall -y ovos-skill-filebrowser
pip3 uninstall -y ovos-skill-installer

deactivate
