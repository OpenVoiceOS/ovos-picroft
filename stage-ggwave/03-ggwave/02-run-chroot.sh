cd /home/ovos
git clone https://github.com/ggerganov/ggwave --recursive
cd ggwave && mkdir build && cd build
sed -i 's/BUILD_SHARED_LIBS_DEFAULT ON/BUILD_SHARED_LIBS_DEFAULT OFF/g' ../CMakeLists.txt
cmake .. && make

mv /home/ovos/ggwave/build/bin/* /home/ovos/.local/bin/
cd /home/ovos
rm -rf ggwave

if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

# Check for python version and install correct ggwave
python_version=`python --version`
if [[ $python_version =~ ".11" ]]; then
    echo "${python_version}  Installing custom wheel"
    pip3 install -U -f https://whl.smartgic.io/ ggwave
else
    echo "${python_version} detected"
    pip3 install -U ggwave
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos-audio-transformer-plugin-ggwave
pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-ggwave

deactivate
