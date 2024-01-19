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

function install_seeed_voicecard () {
    cd /home/ovos/seeed-voicecard
    current_kernel=$1;
    mod=$2
    ver=$3

    dkms build -k ${current_kernel} -m $mod -v $ver && {
            dkms install --force -k ${current_kernel} -m $mod -v $ver
            }
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

# Update and upgrade system packages
apt-get update
apt-get -y dist-upgrade --auto-remove --purge
apt-get clean

cd /home/ovos
git clone https://github.com/OpenVoiceOS/VocalFusionDriver
git clone https://github.com/HinTak/seeed-voicecard
# git clone https://github.com/viraniac/aiyprojects-raspbian
git clone https://github.com/OpenVoiceOS/ovos-i2csound


# Install ovos-i2csound and other required files
cd ovos-i2csound
./install.sh --auto
cd /home/ovos

# Add the button overlays
if [[ ! -f /boot/firmware/overlays/sj201-buttons-overlay.dtbo ]]; then
    cp VocalFusionDriver/sj201-buttons-overlay.dtbo /boot/firmware/overlays/sj201-buttons-overlay.dtbo
fi
if [[ ! -f /boot/firmware/overlays/sj201-rev10-pwm-fan-overlay.dtbo ]]; then
    cp VocalFusionDriver/sj201-rev10-pwm-fan-overlay.dtbo /boot/firmware/overlays/sj201-rev10-pwm-fan-overlay.dtbo
fi

kernels=($(ls /lib/modules))

# seeed-voicecard

ver="0.3"
mod="seeed-voicecard"
marker="0.0.0"

cd /home/ovos/seeed-voicecard
cp *.dtbo /boot/firmware/overlays
cp *.dts /boot/firmware/
mkdir -p /usr/src/$mod-$ver
cp -a ./* /usr/src/$mod-$ver/

dkms add -m $mod -v $ver

# # aiy-voicebonnet-soundcard
#
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
    build_vocalfusion "${k}"
    install_seeed_voicecard "${k}" "${mod}" "${ver}"
#     install_aiy_voicebonnet_soundcard "${k}" "${mod}" "${ver}" "${conf_sound}"
#     install_aiy "${k}" "${mod}" "${ver}" "${conf_driver}"
done

cd /home/ovos
rm -rf VocalFusionDriver
rm -rf seeed-voicecard
# rm -rf aiyprojects-raspbian
rm -rf ovos-i2csound

# Install required Python packages
pip3 install smbus smbus2 spidev rpi.gpio

git clone https://github.com/NeonGeckoCom/sj201-interface
sed -i "s|ovos_utils~=0.0.25|ovos_utils>=0.0.25|" sj201-interface/requirements/requirements.txt
pip3 install ./sj201-interface
rm -rf ./sj201-interface

deactivate
