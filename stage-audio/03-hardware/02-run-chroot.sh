#/bin/bash -e

if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate
fi

build_vocalfusion () {
    current_kernel=$1;
    cd /home/ovos/VocalFusionDriver/driver;
    if [ ! -f Makefile.bk ]; then
        cp Makefile Makefile.bk
    else
        rm Makefile;
        cp Makefile.bk Makefile
    fi
    echo "building VocalFusion for kernel ${current_kernel}"
    sed -i "s|\$(shell uname -r)|$current_kernel|" Makefile
    make all
    mkdir -p "/lib/modules/${current_kernel}/kernel/drivers/vocalfusion"
    cp -v vocalfusion* "/lib/modules/${current_kernel}/kernel/drivers/vocalfusion"

    rm Module.symvers vocalfusion-soundcard.ko vocalfusion-soundcard.mod.c vocalfusion-soundcard.o modules.order vocalfusion-soundcard.mod vocalfusion-soundcard.mod.o

    depmod "${current_kernel}" -a
    cd /home/ovos
}

install_seeed_voicecard () {
    cd /home/ovos/seeed-voicecard
    if [ ! -f Makefile.bk ]; then
        cp Makefile Makefile.bk
    else
        rm Makefile;
        cp Makefile.bk Makefile
    fi
    current_kernel=$1;
    sed -i "s|\$(shell uname -r)|$current_kernel|" Makefile
    sed -i "s|depmod -a|depmod $current_kernel -a|" Makefile
#     mod=$2
#     ver=$3

    make
    make install
    rm *.mod *.ko Module.symvers modules.order
#     dkms build -k ${current_kernel} -m $mod -v $ver && {
#             dkms install --force -k ${current_kernel} -m $mod -v $ver
#             }
    cd /home/ovos
}

install_wm8960 () {
    cd /home/ovos/WM8960-Audio-HAT
    if [ ! -f Makefile.bk ]; then
        cp Makefile Makefile.bk
    else
        rm Makefile;
        cp Makefile.bk Makefile
    fi
    current_kernel=$1;
    sed -i "s|\$(shell uname -r)|$current_kernel|g" Makefile
    sed -i "s|depmod -a|depmod $current_kernel -a|" Makefile

    rm /lib/modules/$current_kernel/kernel/sound/soc/codecs/snd-soc-wm8960.ko*
    make
    make install
    rm *.mod *.ko Module.symvers modules.order
    cd /home/ovos
}

function install_aiy_voicebonnet_soundcard () {
    cd /home/ovos/aiyprojects-raspbian/drivers/sound/debian
    current_kernel=$1;
    mod=$2
    ver=$3
    conf=$4

    dkms build -k ${current_kernel} -m $mod -v $ver -c $conf && {
            dkms install --force -k ${current_kernel} -m $mod -v $ver -c $conf
            }
    cd /home/ovos
}

function install_aiy () {
    cd /home/ovos/aiyprojects-raspbian/drivers/aiy/debian
    current_kernel=$1;
    mod=$2
    ver=$3
    conf=$4

    dkms build -k ${current_kernel} -m $mod -v $ver -c $conf && {
        dkms install --force -k ${current_kernel} -m $mod -v $ver -c $conf
        }
    cd /home/ovos
    }

function install_aiy_leds () {
    cd /home/ovos/aiyprojects-raspbian/drivers/leds/debian
    current_kernel=$1;
    mod=$2
    ver=$3
    conf=$4

    dkms build -k ${current_kernel} -m $mod -v $ver -c $conf && {
        dkms install --force -k ${current_kernel} -m $mod -v $ver -c $conf
        }
    cd /home/ovos
    }

# Update and upgrade system packages
apt-get update
apt-get -y dist-upgrade --auto-remove --purge
apt-get clean

cd /home/ovos
# git clone https://github.com/OpenVoiceOS/VocalFusionDriver
git clone https://github.com/HinTak/seeed-voicecard
# git clone https://github.com/viraniac/aiyprojects-raspbian
git clone https://github.com/OpenVoiceOS/ovos-i2csound
git clone https://github.com/waveshare/WM8960-Audio-HAT

# Install ovos-i2csound and other required files
cd ovos-i2csound
./install.sh --auto #-ap
cd /home/ovos

# Add the button overlays
# if [[ ! -f /boot/firmware/overlays/sj201-buttons-overlay.dtbo ]]; then
#     cp VocalFusionDriver/sj201-buttons-overlay.dtbo /boot/firmware/overlays/sj201-buttons-overlay.dtbo
# fi
# if [[ ! -f /boot/firmware/overlays/sj201-rev10-pwm-fan-overlay.dtbo ]]; then
#     cp VocalFusionDriver/sj201-rev10-pwm-fan-overlay.dtbo /boot/firmware/overlays/sj201-rev10-pwm-fan-overlay.dtbo
# fi

kernels=($(ls /lib/modules))

# seeed-voicecard

seeed_ver="0.3"
seeed_mod="seeed-voicecard"
seeed_marker="0.0.0"

cd /home/ovos/seeed-voicecard
git checkout v6.6
cp *.dtbo /boot/firmware/overlays
cp *.dts /boot/firmware/
# mkdir -p /usr/src/$seeed_mod-$seeed_ver
# cp -a ./* /usr/src/$seeed_mod-$seeed_ver/
#
# dkms add -m $seeed_mod -v $seeed_ver

# vocalfusion

cd /home/ovos/VocalFusionDriver
cp *.dtbo /boot/firmware/overlays
cp *.dts /boot/firmware

# aiy-voicebonnet-soundcard

# ver="2.0-1.2"
# mod="aiy-voicebonnet-soundcard"
# conf_sound="/home/ovos/aiyprojects-raspbian/drivers/sound/debian/aiy-voicebonnet-soundcard-dkms.dkms"
# 
# cd /home/ovos/aiyprojects-raspbian/drivers/sound
# mkdir -p /usr/src/$mod-$ver
# cp -ar ./* /usr/src/$mod-$ver
# 
# dkms add -m $mod -v $ver -c $conf_sound
# 
# # aiy drivers
# 
# mod="aiy-dkms"
# conf_driver="/home/ovos/aiyprojects-raspbian/drivers/aiy/debian/aiy-dkms.dkms"
# 
# cd /home/ovos/aiyprojects-raspbian/drivers/aiy/
# mkdir -p /usr/src/$mod-$ver
# cp -ar ./* /usr/src/$mod-$ver
# 
# dkms add -m $mod -v $ver -c $conf_driver
# 
# # aiy overlays
# cd /home/ovos/aiyprojects-raspbian/drivers/overlays
# ./make_dpkg.sh
# dpkg -i ./aiy-overlay-voice_1.0-1_all.deb
# cd /home/ovos

echo "Looking for kernel with build dir in ${kernels[*]}"
for k in "${kernels[@]}"; do
#     build_vocalfusion "${k}"
    install_seeed_voicecard "${k}" "${mod}" "${ver}"
#     install_aiy_voicebonnet_soundcard "${k}" "${mod}" "${ver}" "${conf_sound}"
#     install_aiy "${k}" "${mod}" "${ver}" "${conf_driver}"
done

cd /home/ovos
# rm -rf VocalFusionDriver
rm -rf seeed-voicecard
# rm -rf aiyprojects-raspbian
rm -rf ovos-i2csound
rm -rf WM8960-Audio-HAT

# Install required Python packages
pip3 install smbus smbus2 spidev rpi.gpio

# pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-mk2-v6-fan-control@update_imports
# pip3 install ovos-PHAL-plugin-mk2-fan-control

deactivate
