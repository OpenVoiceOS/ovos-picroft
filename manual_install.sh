#!/bin/bash

TOP="stage-ovos/00-build/files"

function install_core (){
    echo "installing core"
    echo
    pip install -U pip

    # install ovos-core
    pip install git+https://github.com/OpenVoiceOS/ovos-core
    pip install git+https://github.com/OpenVoiceOS/ovos_PHAL
    pip install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-connectivity-events
    pip install git+https://github.com/OpenVoiceOS/ovos-ocp-audio-plugin
    pip install tornado
    pip install adapt-parser~=0.5
    pip install padacioso~=0.1.2
    pip install PyYAML
    pip install git+https://github.com/OpenVoiceOS/ovos-workshop
    pip install padatious~=0.4.8
    pip install fann2==1.0.7
    pip install git+https://github.com/OpenVoiceOS/ovos-lingua-franca
    pip install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-connectivity-events
    pip install PyAudio~=0.2
    pip install git+https://github.com/OpenVoiceOS/ovos-vad-plugin-webrtcvad
    pip install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-pocketsphinx
    pip install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise
    pip install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-vosk.git
    pip install git+https://github.com/OpenVoiceOS/ovos-stt-plugin-selene
    pip install git+https://github.com/OpenVoiceOS/ovos-stt-plugin-vosk
    pip install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic
    pip install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic2
    pip install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-google-tx

    pip install git+https://github.com/OpenVoiceOS/ovos-config
    pip install git+https://github.com/OpenVoiceOS/ovos-utils
    pip install git+https://github.com/OpenVoiceOS/ovos-backend-client
    pip install git+https://github.com/OpenVoiceOS/ovos-bus-client
    pip install git+https://github.com/OpenVoiceOS/ovos-plugin-manager
    pip install git+https://github.com/OpenVoiceOS/OVOS-workshop
    pip install git+https://github.com/OpenVoiceOS/ovos-lingua-franca
    pip install git+https://github.com/OpenVoiceOS/ovos-cli-client

    # install phal components
    pip install git+https://github.com/OpenVoiceOS/ovos-PHAL
    pip install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-system
    pip install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-connectivity-events
    pip install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-ipgeo
    pip install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-oauth
    pip install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-dashboard
    pip install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-alsa
    pip install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-pulseaudio

    # install tts
    pip install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic
    pip install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic3-server
    pip install git+https://github.com/OpenVoiceOS/ovos-tts-server-plugin

    # install stt
    pip install git+https://github.com/OpenVoiceOS/ovos-stt-plugin-server

    # install ww plugins
    pip install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise-lite

    # install required skills
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-volume
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-fallback-unknown
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-stop
    pip install git+https://github.com/OpenVoiceOS/skill-alerts
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-personal
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-naptime
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-date-time
    echo
    echo "Done installing ovos-core"
    }

function install_systemd (){
    echo
    echo "Installing systemd files"
    echo
    if [[ ! -d /home/$USER/.local/bin ]]; then
        mkdir -p /home/$USER/.local/bin
    fi

    # install the hook files
    cp $TOP/home/ovos/.local/bin/mycroft* /home/$USER/.local/bin/
    chmod +x /home/$USER/.local/bin/mycroft-systemd*

    # sdnotify is required
    pip install sdnotify

    # install the service files
    if [[ ! -d /home/$USER/.config/systemd/user ]]; then
        mkdir -p /home/$USER/.config/systemd/user
    fi
    cp $TOP/usr/lib/systemd/user/* /home/$USER/.config/systemd/user/

    if [[ $enabled == "YES" ]]; then
        echo
        echo "Enabling service files"
        echo
        systemctl --user enable mycroft
        systemctl --user enable mycroft-messagebus
        systemctl --user enable mycroft-audio
        systemctl --user enable mycroft-voice
        systemctl --user enable mycroft-skills
        systemctl --user enable mycroft-phal
        systemctl --user enable mycroft-admin-phal
    fi
    echo
    echo "Done installing systemd files"
    echo
    }

function install_extra_skills (){
    echo
    echo "Installing extra skills"
    echo
    # from NeonGeckoCom
    pip install git+https://github.com/NeonGeckoCom/skill-user_settings
    pip install git+https://github.com/NeonGeckoCom/skill-spelling
    pip install git+https://github.com/NeonGeckoCom/skill-local_music
    pip install git+https://github.com/NeonGeckoCom/skill-caffeinewiz

    pip install git+https://github.com/OpenVoiceOS/skill-ovos-weather
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-hello-world

    # common query
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-ddg
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-wolfie
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-wikipedia

    # fallback
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-fallback-chatgpt

    # OCP
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-news
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-somafm
    pip install git+https://github.com/OpenVoiceOS/skill-ovos-youtube-music

    # non pip skills
    if [[ ! -d /home/$USER/.local/share/mycroft/skills ]]; then
        mkdir -p /home/$USER/.local/share/mycroft/skills
    fi
    cd /home/$USER/.local/share/mycroft/skills
    # jarbasskills
    git clone https://github.com/JarbasSkills/skill-icanhazdadjokes.git
    pip install -r skill-icanhazdadjokes/requirements.txt
    cd /home/$USER
    echo
    echo "Done installing extra skills"
    echo
    }

echo "This file will install ovos-core to this device"
echo "using the latest commits from github."
echo
echo "First lets setup some things."
echo
read -p "Do you want to install systemd files (Y/n): " systemd
if [[ ! $systemd || $systemd[0] == "y" || $systemd[0] == "Y" ]]; then
    systemd="YES"
    echo
    read -p "Do you want to automatically start the ovos services? (Y/n): " enabled
    if [[ ! $enabled || $enabled[0] == "y" || $enabled[0] == "Y" ]]; then
        enabled="YES"
    fi
fi
echo
read -p "Would you like to install extra skills to match the downloadable image? (Y/n): " extra_skills
if [[ ! $extra_skills || $extra_skills[0] == "y" || $extra_skills[0] == "Y" ]]; then
    extra_skills="YES"
fi
echo
echo "We are now ready to install OVOS"
echo
read -p "Type 'Y' to start install (any other key aborts): " install
if [[ $install != "Y" ]]; then
    exit[0]
fi

install_core

if [[ $systemd == "YES" ]]; then
    install_systemd
fi

if [[ $extra_skills == "YES" ]]; then
    install_extra_skills
fi

echo "Done installing OVOS"
echo
read -p "Would you like to start ovos now? (Y/n): " start
if [[ ! $start || $start[0] == "y" || $start[0] == "Y" ]]; then
    systemctl --user start mycroft

else
    echo
    echo "You can start the ovos services with `systemctl --user start mycroft`"
    echo
fi

echo
echo "Enjoy your OVOS device"
exit 0
