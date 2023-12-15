#/bin/bash -e

if [[ ! ${VIRTUAL_ENV} ]]; then
source /home/ovos/.venv/bin/activate;
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
    cp vocalfusion* "/lib/modules/${current_kernel}/kernel/drivers/vocalfusion"
    rm Module.symvers vocalfusion-soundcard.ko vocalfusion-soundcard.mod.c vocalfusion-soundcard.o modules.order vocalfusion-soundcard.mod vocalfusion-soundcard.mod.o

    depmod "${current_kernel}" -a
    cd /home/ovos
}

apt-get update
apt-get -y dist-upgrade --auto-remove --purge
apt-get clean

cd /home/ovos
git clone https://github.com/OpenVoiceOS/VocalFusionDriver

# Add the button overlays
if [[ ! -f /boot/firmware/overlays/sj201-buttons-overlay.dtbo ]]; then
    cp VocalFusionDriver/sj201-buttons-overlay.dtbo /boot/firmware/overlays/sj201-buttons-overlay.dtbo
fi
if [[ ! -f /boot/firmware/overlays/sj201-rev10-pwm-fan-overlay.dtbo ]]; then
    cp VocalFusionDriver/sj201-rev10-pwm-fan-overlay.dtbo /boot/firmware/overlays/sj201-rev10-pwm-fan-overlay.dtbo
fi

kernels=($(ls /lib/modules))
echo "Looking for kernel with build dir in ${kernels[*]}"
for k in "${kernels[@]}"; do
    build_vocalfusion "${k}"
done

# if [[ "${k}" == *2712 ]]; then
# echo "RPi5 kernel"
# else
# kernel="${k}"
# echo "Selected kernel ${kernel}"
# break
# fi
# done

# VocalFusion SJ201 drivers

# cd VocalFusionDriver/driver
# sed -i "s|\$(shell uname -r)|$kernel|" Makefile
# make all
# mkdir -p "/lib/modules/${kernel}/kernel/drivers/vocalfusion"
# cp vocalfusion* "/lib/modules/${kernel}/kernel/drivers/vocalfusion"
# cd /home/ovos
# rm -rf VocalFusionDriver
# depmod "${kernel}" -a

pip3 install smbus smbus2 spidev rpi.gpio

pip3 install git+https://github.com/NeonGeckoCom/sj201-interface
pip3 install git+https://github.com/NeonGeckoCom/neon-phal-plugin-linear_led
pip3 install git+https://github.com/NeonGeckoCom/neon-phal-plugin-switches
pip3 install git+https://github.com/NeonGeckoCom/neon-phal-plugin-fan

deactivate
