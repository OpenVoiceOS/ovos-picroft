if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi


pip3 install git+https://github.com/builderjer/ovos-PHAL-plugin-hotkeys@feat/autodetect # I like the autodetect feature

deactivate
