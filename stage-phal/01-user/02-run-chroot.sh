if [[ ! ${VIRTUAL_ENV} ]]; then
    source /home/ovos/.venv/bin/activate;
fi

# pip3 install ovos-PHAL
# 
# pip3 install ovos-PHAL-plugin-alsa # Stable version is old
# pip3 install ovos-PHAL-plugin-balena-wifi # Stable version is old
# pip3 install ovos-PHAL-plugin-wifi-setup # Stable version is old
# 
# pip3 install ovos-PHAL-plugin-system
# pip3 install ovos_utils
# 
# pip3 install ovos-PHAL-plugin-ipgeo
# pip3 install ovos-PHAL-plugin-connectivity-events
# 
# pip3 install ovos-PHAL-plugin-dotstar

pip3 install git+https://github.com/builderjer/ovos-PHAL-plugin-hotkeys@feat/autodetect # I like the autodetect feature

deactivate
