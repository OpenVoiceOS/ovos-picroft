if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install git+https://github.com/NeonGeckoCom/sj201-interface

# VocalFusion SJ201 drivers
cd /home/ovos
git clone https://github.com/OpenVoiceOS/VocalFusionDriver
cd VocalFusionDriver/driver
make all
kernel=$(uname -r)
mkdir -p "/lib/modules/${kernel}/kernel/drivers/vocalfusion"
cp vocalfusion* "/lib/modules/${kernel}/kernel/drivers/vocalfusion"
cd /home/ovos
rm -rf VocalFusionDriver
depmod "${kernel}" -a

pip3 install git+https://github.com/NeonGeckoCom/neon-phal-plugin-linear_led
pip3 install git+https://github.com/NeonGeckoCom/neon-phal-plugin-switches
pip3 install git+https://github.com/NeonGeckoCom/neon-phal-plugin-fan

deactivate
