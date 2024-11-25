if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

if [[ -e /etc/environment ]]; then
    rm /etc/environment
    ln -s /etc/environment /etc/environment.d/99-ovos-environment
fi

deactivate
