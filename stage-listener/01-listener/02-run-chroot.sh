
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

# pip3 install fann2==1.0.7
# pip3 install ovos-padatious
# 
# pip3 install ovos-dinkum-listener
# pip3 install ovos-vad-plugin-silero
# 
# pip3 install ovos-stt-plugin-server
# 
# pip3 install ovos-ww-plugin-precise-lite
# pip3 install ovos-ww-plugin-pocketsphinx # Stable version is old
# pip3 install ovos-ww-plugin-vosk # Stable version is old
# 
# pip3 install ovos-PHAL-plugin-alsa
# pip3 install ovos-microphone-plugin-alsa # Stable version is old

deactivate
