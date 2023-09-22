cd /home/ovos
git clone https://github.com/ggerganov/ggwave --recursive
cd ggwave && mkdir build && cd build
sed -i 's/BUILD_SHARED_LIBS_DEFAULT ON/BUILD_SHARED_LIBS_DEFAULT OFF/g' ../CMakeLists.txt
cmake .. && make

mv /home/ovos/ggwave/build/bin/* /home/ovos/.local/bin/
rm -rf ggwave

pip3 https://github.com/OpenVoiceOS/ovos-audio-transformer-plugin-ggwave
