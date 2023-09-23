# Check for python version and install correct tflite_runtime
python_version=`python --version`
if [[ $python_version =~ ".9" ]]; then
    echo "${python_version}  Installing custom wheel"
    pip3 install -U -f https://whl.smartgic.io/tflite_runtime-2.14.0-cp39-cp39-linux_aarch64.whl;
else
    echo "${python_version} detected"
    pip3 install -U -f tflite_runtime
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos-dinkum-listener
pip3 install git+https://github.com/OpenVoiceOS/ovos-vad-plugin-silero
pip3 install git+https://github.com/OpenVoiceOS/ovos-stt-plugin-server
pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-openWakeWord
pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise-lite
pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-pocketsphinx
pip3 install git+https://github.com/OpenVoiceOS/ovos-microphone-plugin-alsa
