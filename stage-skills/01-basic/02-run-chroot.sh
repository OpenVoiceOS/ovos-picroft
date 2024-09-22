if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install ovos-skill-date-time
pip3 install ovos-skill-naptime
pip3 install ovos-skill-personal
pip3 install ovos-skill-volume
pip3 install ovos-skill-weather
pip3 install ovos-skill-fallback-unknown
pip3 install ovos-skill-wikipedia # Stable version is old
pip3 install skill-wolfie
pip3 install ovos-skill-alerts
pip3 install ovos-skill-tunein
pip3 install ovos-skill-somafm
pip3 install skill-ddg
pip3 install ovos-skill-youtube-music
pip3 install skill-news
pip3 install ovos-skill-pyradios
pip3 install ovos-skill-boot-finished
pip3 install ovos-skill-ggwave

deactivate
