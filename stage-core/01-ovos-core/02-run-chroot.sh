if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip install git+https://github.com/OpenVoiceOS/ovos-core

if [[ -e /etc/environment ]]; then
    rm /etc/environment
    ln -s /etc/environment /etc/environment.d/99-ovos-environment
fi

if [[ -e /etc/environment ]]; then
    rm /etc/environment
    ln -s /etc/environment /etc/environment.d/99-ovos-environment
fi

deactivate
