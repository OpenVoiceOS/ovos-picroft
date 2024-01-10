if [[ ! ${VIRTUAL_ENV} ]]; then
source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos-audio
pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-piper
pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-server-plugin
pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic
pip3 install git+https://github.com/OpenVoiceOS/ovos-vlc-plugin

pip3 install espeak_phonemizer


# cd /home/ovos
# git clone https://github.com/libfann/fann.git
# cd fann
# cmake .
# make install
# cd ..
# rm -rf fann
apt update

deactivate
