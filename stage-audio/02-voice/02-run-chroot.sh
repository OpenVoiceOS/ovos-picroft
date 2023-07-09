# custom tflite_runtime to work with python 3.9 and raspbian bullseye
pip3 install -U -f 'https://whl.smartgic.io/' tflite_runtime

pip3 install git+https://github.com/OpenVoiceOS/ovos-dinkum-listener
pip3 install git+https://github.com/OpenVoiceOS/ovos-vad-plugin-silero
pip3 install git+https://github.com/OpenVoiceOS/ovos-stt-plugin-server
pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-openWakeWord
pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise-lite
pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-pocketsphinx
pip3 install git+https://github.com/OpenVoiceOS/ovos-microphone-plugin-alsa
