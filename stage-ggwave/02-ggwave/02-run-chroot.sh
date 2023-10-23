if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

cd /home/ovos

git clone https://github.com/ggerganov/ggwave --recursive
cd ggwave && mkdir build && cd build
cmake ..
make
mv ./bin/* /home/ovos/.local/bin
cd /home/ovos
rm -rf ggwave

pip3 install git+https://github.com/OpenVoiceOS/ovos-audio-transformer-plugin-ggwave

deactivate
