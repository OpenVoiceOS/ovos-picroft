if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos-ocp-audio-plugin
pip3 install git+https://github.com/OpenVoiceOS/ovos-ocp-rss-plugin
pip3 install git+https://github.com/OpenVoiceOS/ovos-ocp-news-plugin
pip3 install git+https://github.com/OpenVoiceOS/ovos-ocp-youtube-plugin
pip3 install git+https://github.com/OpenVoiceOS/ovos-ocp-bandcamp-plugin
pip3 install git+https://github.com/OpenVoiceOS/ovos-ocp-m3u-plugin
pip3 install git+https://github.com/OpenVoiceOS/ovos-plugin-vlc

deactivate
