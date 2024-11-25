if [[ ! ${VIRTUAL_ENV} ]]; then
source /home/ovos/.venv/bin/activate;
fi

# pip3 install ovos-audio
# pip3 install ovos-tts-plugin-piper
# pip3 install ovos-tts-plugin-server
# pip3 install ovos-tts-plugin-mimic
# pip3 install ovos-plugin-vlc
# pip3 install ovos-audio-plugin-mpv

pip3 install espeak_phonemizer

deactivate
