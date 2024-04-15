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
git clone https://github.com/OpenVoiceOS/VocalFusionDriver
git clone https://github.com/HinTak/seeed-voicecard
git clone https://github.com/viraniac/aiyprojects-raspbian
git clone https://github.com/OpenVoiceOS/ovos-i2csound


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

aiy_sound_ver="3.0-1.3"
aiy_sound_mod="aiy-voicebonnet-soundcard"
aiy_conf_sound="/home/ovos/aiyprojects-raspbian/drivers/sound/debian/aiy-voicebonnet-soundcard-dkms.dkms"
#
cd /home/ovos/aiyprojects-raspbian/drivers/sound
mkdir -p /usr/src/$aiy_sound_mod-$aiy_sound_ver
cp -ar ./* /usr/src/$aiy_sound_mod-$aiy_sound_ver
cp -ar ./debian/ucm2* /usr/share/alsa/ucm2/

dkms add -m $aiy_sound_mod -v $aiy_sound_ver -c $aiy_conf_sound

# aiy drivers

aiy_drivers_ver="2.0-1.2"
aiy_drivers_mod="aiy-dkms"
aiy_conf_driver="/home/ovos/aiyprojects-raspbian/drivers/aiy/debian/aiy-dkms.dkms"

cd /home/ovos/aiyprojects-raspbian/drivers/aiy/
mkdir -p /usr/src/$aiy_drivers_mod-$aiy_drivers_ver
cp -ar ./* /usr/src/$aiy_drivers_mod-$aiy_drivers_ver

dkms add -m $aiy_drivers_mod -v $aiy_drivers_ver -c $aiy_conf_driver

# aiy led drivers
aiy_led_drivers_ver="2.0-1.2"
aiy_led_drivers_mod="leds-ktd202x"
aiy_led_drivers_conf="/home/ovos/aiyprojects-raspbian/drivers/leds/debian/leds-ktd202x-dkms.dkms"

cd /home/ovos/aiyprojects-raspbian/drivers/leds
mkdir -p /usr/src/$aiy_led_drivers_mod-$aiy_led_drivers_ver
cp -ar ./* /usr/src/$aiy_led_drivers_mod-$aiy_led_drivers_ver

dkms add -m $aiy_led_drivers_mod -v $aiy_led_drivers_ver -c $aiy_led_drivers_conf

# aiy overlays
cd /home/ovos/aiyprojects-raspbian/drivers/overlays
./make_dpkg.sh
dpkg -i ./aiy-overlay-voice_1.0-1_all.deb
cp ./voice/opt/aiy/overlay-voice/* /boot/firmware/
cd /home/ovos

echo "Looking for kernel with build dir in ${kernels[*]}"
for k in "${kernels[@]}"; do
    if [[ "${k}" == *6.6* ]]; then
        build_vocalfusion "${k}"
        install_seeed_voicecard "${k}"
    #     install_seeed_voicecard "${k}" "${seeed_mod}" "${seeed_ver}"
        install_aiy_voicebonnet_soundcard "${k}" "${aiy_sound_mod}" "${aiy_sound_ver}" "${aiy_conf_sound}"
        install_aiy "${k}" "${aiy_drivers_mod}" "${aiy_drivers_ver}" "${aiy_conf_driver}"
        install_aiy_leds "${k}" "$aiy_led_drivers_mod" "${aiy_drivers_ver}" "${aiy_led_drivers_conf}"
    fi
done

cd /home/ovos
rm -rf VocalFusionDriver
rm -rf seeed-voicecard
rm -rf aiyprojects-raspbian
rm -rf ovos-i2csound

# Install required Python packages
pip3 install smbus smbus2 spidev rpi.gpio

pip3 install git+https://github.com/NeonGeckoCom/sj201-interface
pip3 install git+https://github.com/smartgic/ovos-phal-plugin-aiy-v2

deactivate
