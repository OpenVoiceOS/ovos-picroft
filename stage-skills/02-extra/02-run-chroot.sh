if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

# ovos skills
pip3 install skill-easter-eggs
pip3 install ovos-skill-icanhazdadjokes
pip3 install ovos-skill-moviemaster

deactivate
