#/bin/bash -e

if [[ ! ${VIRTUAL_ENV} ]]; then
source /home/ovos/.venv/bin/activate;
fi

kernels=($(ls /lib/modules))
echo "Looking for kernel with build dir in ${kernels[*]}"
for k in "${kernels[@]}"; do
if [[ "${k}" == *2712 ]]; then
echo "RPi5 kernel"
else
kernel="${k}"
echo "Selected kernel ${kernel}"
break
fi
done

# VocalFusion SJ201 drivers
cd /home/ovos
git clone https://github.com/OpenVoiceOS/VocalFusionDriver
cd VocalFusionDriver/driver
sed -i "s|\$(shell uname -r)|$kernel|" Makefile
make all
mkdir -p "/lib/modules/${kernel}/kernel/drivers/vocalfusion"
cp vocalfusion* "/lib/modules/${kernel}/kernel/drivers/vocalfusion"
cd /home/ovos
rm -rf VocalFusionDriver
depmod "${kernel}" -a

pip3 install smbus smbus2 spidev rpi.gpio

pip3 install git+https://github.com/NeonGeckoCom/sj201-interface
pip3 install git+https://github.com/NeonGeckoCom/neon-phal-plugin-linear_led
pip3 install git+https://github.com/NeonGeckoCom/neon-phal-plugin-switches
pip3 install git+https://github.com/NeonGeckoCom/neon-phal-plugin-fan

deactivate
