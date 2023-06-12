#!/bin/bash

TOP="stage-ovos/00-build/files"

function install_core (){
    echo "installing core"
    echo
    pip3 install -U pip

    # install ovos-core - ovos-backend-client has conflicting dependencies
    pip3 install git+https://github.com/OpenVoiceOS/ovos-backend-client
    pip3 install git+https://github.com/OpenVoiceOS/ovos-core
    pip3 install git+https://github.com/OpenVoiceOS/ovos-audio
    pip3 install git+https://github.com/OpenVoiceOS/ovos-ocp-audio-plugin
    pip3 install tornado
    pip3 install git+https://github.com/OpenVoiceOS/ovos-messagebus
    pip3 install adapt-parser~=1.0.0
    pip3 install padacioso~=0.2

    # ovos voice depends on ovos-listener
    pip3 install git+https://github.com/OpenVoiceOS/ovos-listener

    # ovos_listener.mic tries to create VAD engine with ovos-vad-plugin-webrtcvad
    pip3 install ovos-vad-plugin-webrtcvad

    # dinkum listener
    pip3 install git+https://github.com/OpenVoiceOS/ovos-dinkum-listener
    pip3 install git+https://github.com/OpenVoiceOS/ovos-vad-plugin-silero
    #Precise-lite cluster
    sudo apt install -y python3-scipy
    pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise-lite
    python3 -m pip3 install --upgrade setuptools
    pip3 install --no-cache-dir --force-reinstall -Iv grpcio 
    pip3 install --no-cache-dir --force-reinstall -Iv grpcio-tools
    # pip3 install tflite_runtime # can be problematic so...
    # we install full tensorflow (because it just works, takes a while to install)
    sudo apt install libatlas-base-dev
    pip3 install tensorflow --no-cache-dir

    pip3 install PyYAML
    pip3 install git+https://github.com/OpenVoiceOS/ovos-workshop
    pip3 install fann2
    pip3 install padatious~=0.4.8
    pip3 install git+https://github.com/OpenVoiceOS/ovos-lingua-franca
    pip3 install PyAudio~=0.2
    pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-pocketsphinx
    pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise
#    pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-vosk

    # install stt
    pip3 install git+https://github.com/OpenVoiceOS/ovos-stt-plugin-server
    pip3 install git+https://github.com/OpenVoiceOS/ovos-stt-plugin-selene
#    pip3 install git+https://github.com/OpenVoiceOS/ovos-stt-plugin-vosk

    # install text to speech
    # https://stackoverflow.com/questions/7088672/pyaudio-working-but-spits-out-error-messages-each-time
    pip3 install git+https://github.com/OpenVoiceOS/ovos-microphone-plugin-alsa
    pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic3-server
    pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-server-plugin
    pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic
    pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic2
    pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-google-tx

    pip3 install git+https://github.com/OpenVoiceOS/ovos-config
    pip3 install git+https://github.com/OpenVoiceOS/ovos-utils
    pip3 install git+https://github.com/OpenVoiceOS/ovos-bus-client
    pip3 install git+https://github.com/OpenVoiceOS/ovos-plugin-manager
    pip3 install git+https://github.com/OpenVoiceOS/ovos-workshop
    pip3 install git+https://github.com/OpenVoiceOS/ovos-lingua-franca
    pip3 install git+https://github.com/OpenVoiceOS/ovos-cli-client

    # install phal components
    pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL
    pip3 install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-connectivity-events
    pip3 install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-system
    pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-ipgeo
    pip3 install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-oauth
    pip3 install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-dashboard
    pip3 install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-alsa

    sudo apt install -y pulseaudio
    pip3 install git+https://github.com/OpenVoiceOS/ovos-phal-plugin-pulseaudio

    # install required skills
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-volume
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-fallback-unknown
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-stop
    pip3 install git+https://github.com/OpenVoiceOS/skill-alerts
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-personal
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-naptime
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-date-time
    echo
    echo "Done installing ovos-core"
    }

function install_systemd (){
    echo
    echo "Installing systemd files"
    echo
    cd $HOME/raspbian-ovos/stage-ovos/00-system/files
    sed -i s/multi-user/default/g ovos.service
    for f in *.service ; do
      sed -i s,/usr/libexec,/home/ovos/.local/bin,g $f
    done

    # install the hook files
    cp ovos-systemd*  $HOME/.local/bin/
    chmod +x $HOME/.local/bin/ovos-systemd*

    # sdnotify is required
    pip3 install sdnotify

    # install the service files
    if [[ ! -d $HOME/.config/systemd/user ]]; then
        mkdir -p $HOME/.config/systemd/user
    fi
    sed -i s/User=root/#User=root/g ovos-admin-phal.service
    cp *.service $HOME/.config/systemd/user/

    if [[ $enabled == "YES" ]]; then
        echo
        echo "Enabling service files"
        echo
        systemctl --user enable ovos
        systemctl --user enable ovos-messagebus
        systemctl --user enable ovos-dinkum-listener
        systemctl --user disable ovos-listener
        systemctl --user enable ovos-audio
        systemctl --user enable ovos-voice
        systemctl --user enable ovos-skills
        systemctl --user enable ovos-phal
        systemctl --user enable ovos-admin-phal
        systemctl --user daemon-reload
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
    pip3 install git+https://github.com/NeonGeckoCom/skill-user_settings
    pip3 install git+https://github.com/NeonGeckoCom/skill-spelling
    pip3 install git+https://github.com/NeonGeckoCom/skill-local_music
    pip3 install git+https://github.com/NeonGeckoCom/skill-caffeinewiz

    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-weather
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-hello-world

    # common query
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-ddg
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-wolfie
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-wikipedia

    # fallback
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-fallback-chatgpt

    # OCP
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-news
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-somafm
    pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-youtube-music

    # non pip3 skills
    if [[ ! -d $HOME/.local/share/mycroft/skills ]]; then
        mkdir -p $HOME/.local/share/mycroft/skills
    fi
    cd $HOME/.local/share/mycroft/skills
    # jarbasskills
    git clone https://github.com/JarbasSkills/skill-icanhazdadjokes.git
    pip3 install -r skill-icanhazdadjokes/requirements.txt
    cd $HOME
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
    if [[ -z "$enabled" || $enabled == y* || $enabled == Y* ]]; then
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
    if [[ ! -d $HOME/.local/bin ]]; then
        mkdir -p $HOME/.local/bin
    fi
    PATH=/home/ovos/.local/bin:$PATH
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
    if [[ -z "$start" || $start == y* || $start == Y* ]]; then
        systemctl --user start ovos

    else
        echo
        echo "You can start the ovos services with 'systemctl --user start ovos'"
        echo
    fi

    echo
    echo "Enjoy your OVOS device"
fi

exit 0
