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
    if [[ ! -d $HOME/.local/bin ]]; then
        mkdir -p $HOME/.local/bin
    fi

    # install the hook files
    cp $TOP/usr/libexec/ovos* $HOME/.local/bin/
    chmod +x $HOME/.local/bin/ovos-systemd*

    # sdnotify is required
    pip install sdnotify

    # install the service files
    if [[ ! -d $HOME/.config/systemd/user ]]; then
        mkdir -p $HOME/.config/systemd/user
    fi
    cp $TOP/usr/lib/systemd/user/* $HOME/.config/systemd/user/

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

    pip install git+https://github.com/JarbasSkills/skill-icanhazdadjokes
    echo
    echo "Done installing extra skills"
    echo
    }

echo
echo "This file will install ovos-core to this device"
echo "using the latest commits from github."
echo
echo "First lets setup some things."
echo
read -p "Do you want to install systemd files (Y/n): " systemd
if [[ -z "$systemd" || $systemd == y* || $systemd == Y* ]]; then
    systemd="YES"
    echo
    read -p "Do you want to automatically start the ovos services? (Y/n): " enabled
    if [[ -z "$enabled" || $enabled[0] == "y" || $enabled[0] == "Y" ]]; then
        enabled="YES"
    fi
fi
echo
read -p "Would you like to install extra skills to match the downloadable image? (Y/n): " extra_skills
if [[ -z "$extra_skills" || $extra_skills == y* || $extra_skills == Y* ]]; then
    extra_skills="YES"
fi
echo
echo "We are now ready to install OVOS"
echo
read -p "Type 'Y' to start install (any other key aborts): " install
if [[ $install == Y* || $install == y* ]]; then
    install_core

    if [[ $systemd == "YES" ]]; then
        install_systemd
    fi

    if [[ $extra_skills == "YES" ]]; then
        install_extra_skills
    fi

    echo "Done installing OVOS"
    echo
    if [[ $systemd="YES" ]]; then
        read -p "Would you like to start ovos now? (Y/n): " start
        if [[ -z "$start" || $start == y* || $start == Y* ]]; then
            systemctl --user start ovos

        else
            if [[ $enabled == "YES" ]]; then
                echo
                echo "OVOS will be started on next reboot"
                echo
            else
                echo
                echo "You can start the ovos services with `systemctl --user start ovos`"
                echo
            fi
        fi
    fi

    echo
    echo "Enjoy your OVOS device"
fi

exit 0
