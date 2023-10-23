if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install sdnotify
pip3 install git+https://github.com/OpenVoiceOS/ovos-messagebus

deactivate
