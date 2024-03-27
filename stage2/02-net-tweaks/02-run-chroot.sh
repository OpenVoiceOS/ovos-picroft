#!/bin/bash -e

if [ -v WPA_COUNTRY ]; then
		SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_wifi_country "${WPA_COUNTRY}"
fi
