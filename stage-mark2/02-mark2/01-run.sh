if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

cd /home/ovos
git clone https://github.com/OpenVoiceOS/VocalFusionDriver.git
cd VocalFusionDriver/driver
make all

deactivate
