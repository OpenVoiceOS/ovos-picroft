if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip3 install ovos-plugin-manager
pip3 install ovos-bus-client
pip3 install ovos-core

if [[ -e /etc/environment ]]; then
    rm /etc/environment
    ln -s /etc/environment /etc/environment.d/99-ovos-environment
fi

deactivate
