if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/OpenVoiceOS/ovos-gui-plugin-shell-companion
pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-homescreen
pip3 install git+https://github.com/OpenVoiceOS/ovos-gui

pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-gui-network-client

# Mycroft-gui-qt5
cd /home/ovos
git clone https://github.com/OpenVoiceOS/mycroft-gui-qt5
cd mycroft-gui-qt5
mkdir build && cd build
cmake .. -DBUILD_WITH_QT6=OFF -DQT_MAJOR_VERSION=5 -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make
make install
cd /home/ovos
rm -rf mycroft-gui-qt5

cd /home/ovos
git clone https://github.com/OpenVoiceOS/ovos-shell
cd ovos-shell
echo " "
echo "Building OVOS GUI"
if [[ ! -d build-testing ]] ; then
    mkdir build-testing
fi
cd build-testing
cmake .. -DBUILD_WITH_QT6=OFF -DQT_MAJOR_VERSION=5 -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make
make install
cd /home/ovos
rm -rf ovos-shell

git clone https://github.com/kbroulik/lottie-qml
cd lottie-qml
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make
make install
cd /home/ovos
rm -rf lottie-qml

deactivate
