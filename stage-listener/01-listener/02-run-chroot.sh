
if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi
# Check for python version and install correct tflite_runtime
python_version=`python --version`
if [[ $python_version =~ ".9" ]]; then
    echo "${python_version}  Installing custom wheel"
    pip3 install -U -f https://whl.smartgic.io/ tflite_runtime
else
    echo "${python_version} detected"
    pip3 install -U tflite_runtime
fi

pip3 install fann2==1.0.7
pip3 install git+https://github.com/MycroftAI/padatious

pip3 install git+https://github.com/OpenVoiceOS/ovos-dinkum-listener
pip3 install git+https://github.com/OpenVoiceOS/ovos-vad-plugin-silero

pip3 install git+https://github.com/OpenVoiceOS/ovos-stt-plugin-server

pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise-lite
pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-pocketsphinx
pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-vosk

pip3 install git+https://github.com/emphasize/ovos-PHAL-plugin-alsa
pip3 install git+https://github.com/OpenVoiceOS/ovos-microphone-plugin-sounddevice
pip3 install git+https://github.com/OpenVoiceOS/ovos-microphone-plugin-alsa

deactivate
