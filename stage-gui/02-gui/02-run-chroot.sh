if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install ovos-gui-plugin-shell-companion # Stable version is old
pip3 install ovos-skill-homescreen
pip3 install ovos-gui

pip3 install ovos-PHAL-plugin-wallpaper-manager
pip3 install ovos-skill-wallpapers

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


# Build the on screen keyboard
git clone https://invent.kde.org/qt/qt/qtvirtualkeyboard/ -b v5.15.8-lts-lgpl
cd qtvirtualkeyboard/src/virtualkeyboard
rm qvirtualkeyboardinputcontext_p.cpp
wget https://raw.githubusercontent.com/NeonGeckoCom/neon_debos/dev/overlays/00-build-qt-keyboard/var/qvirtualkeyboardinputcontext_p.cpp
cd ../..
qmake . CONFIG+="lang-all handwriting"
make -j
make install

deactivate
