if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

pip install --pre ovos-core[skills-essential]

if [[ -e /etc/environment ]]; then
    rm /etc/environment
    ln -s /etc/environment /etc/environment.d/99-ovos-environment
fi

deactivate
