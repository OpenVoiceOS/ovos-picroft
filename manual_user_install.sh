#!/bin/bash

# Exit on error
# If something goes wrong just stop. The script should be re-runnable
# and it allows the user to see issues at once rather than having
# scroll back and figure out what went wrong.
set -e

# tested with a clean 64 bit installation of Raspbian-Lite

function get_src() {
    mkdir -p ${OVOS_SOURCE}
    pushd ${OVOS_SOURCE}
    echo Cloning source to ${OVOS_SOURCE}
    for p in ovos-backend-client \
		 ovos-core ovos-audio ovos-ocp-audio-plugin \
		 ovos-messagebus ovos-dinkum-listener \
		 ovos-vad-plugin-silero \
		 ovos-ww-plugin-pocketsphinx ovos-ww-plugin-precise \
		 ovos-ww-plugin-precise-lite ovos-workshop ovos-lingua-franca \
		 ovos-microphone-plugin-alsa ovos-stt-plugin-server \
		 ovos-tts-plugin-mimic3-server ovos-tts-plugin-mimic \
		 ovos-tts-plugin-piper ovos-tts-server-plugin ovos-config \
		 ovos-utils ovos-bus-client ovos-plugin-manager \
		 ovos-cli-client ovos-PHAL ovos-phal-plugin-connectivity-events \
		 ovos-phal-plugin-system ovos-PHAL-plugin-ipgeo \
		 ovos-PHAL-plugin-oauth ovos-phal-plugin-dashboard \
		 ovos-phal-plugin-alsa skill-ovos-volume \
		 skill-ovos-fallback-unknown skill-ovos-stop \
		 skill-alerts skill-ovos-personal skill-ovos-naptime \
		 skill-ovos-date-time $OVOS_EXTRA_SKILL_REPOS; do
	echo Cloning $p
	[[ -d $p ]] || git clone https://github.com/OpenVoiceOS/$p
    done
    popd
}

function install_core (){
    echo "Installing OVOS core"
    echo

    # set up the Raspberry Pi
    echo $sudoPW | sudo -S apt install -y build-essential python3-dev python3-pip swig libssl-dev libfann-dev portaudio19-dev libpulse-dev cmake libncurses-dev pulseaudio-utils pulseaudio
    pulseaudio -D

    # install ovos-core
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-backend-client
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-core
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-audio
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-ocp-audio-plugin
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-messagebus
    # padatious required to support newest ovos-core
    # pip3 install padatious

    # dinkum listener
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-dinkum-listener
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-vad-plugin-silero
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-ww-plugin-pocketsphinx

    #Precise-lite wake-word (ww) cluster
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-ww-plugin-precise
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-ww-plugin-precise-lite
    pip3 install --upgrade setuptools
    pip3 install tflite_runtime
    pip3 install PyYAML
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-workshop
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-lingua-franca
    pip3 install PyAudio

    # install speech to text (stt)
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-microphone-plugin-alsa
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-stt-plugin-server

    # install text to speech (tts)
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-tts-plugin-mimic3-server
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-tts-plugin-mimic
    echo $sudoPW | sudo -S apt install -y espeak-ng
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-tts-plugin-piper
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-tts-server-plugin

    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-config
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-utils
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-bus-client
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-plugin-manager
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-cli-client

    # install phal components
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-PHAL
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-phal-plugin-connectivity-events
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-phal-plugin-system
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-PHAL-plugin-ipgeo
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-PHAL-plugin-oauth
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-phal-plugin-dashboard
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/ovos-phal-plugin-alsa

    # install required skills
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-volume
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-fallback-unknown
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-stop
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-alerts
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-personal
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-naptime
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-date-time

    # You can uncomment these lines if the deprecation notices are flooding your logs or slowing the system
    #sed -i '/\@deprecated/d' $HOME/.local/lib/python3.9/site-packages/ovos_utils/fingerprinting.py
    #sed -i '/\@deprecated/d' $HOME/.local/lib/python3.9/site-packages/ovos_utils/configuration.py
    #sed -i '/\@deprecated/d' $HOME/.local/lib/python3.9/site-packages/ovos_utils/ovos_service_api.py
    #sed -i '/\@deprecated/d' $HOME/.local/lib/python3.9/site-packages/ovos_utils/signal.py

    if [[ ! -d $HOME/.config/mycroft ]]; then
        mkdir -p $HOME/.config/mycroft
    fi
    cp $SCRIPT_DIR/stage-core/01-ovos-core/files/mycroft.conf $HOME/.config/mycroft/
    echo $SCRIPT_DIR
    echo
    echo "Done installing OVOS core"
    }

function install_systemd (){
    echo
    echo "Installing systemd files"
    echo

    # install the hook files
    cp $SCRIPT_DIR/stage-core/01-ovos-core/files/ovos-systemd-skills $HOME/.local/bin/
    cp $SCRIPT_DIR/stage-core/02-messagebus/files/ovos-systemd-messagebus $HOME/.local/bin/
    cp $SCRIPT_DIR/stage-audio/01-speech/files/ovos-systemd-audio $HOME/.local/bin/
    cp $SCRIPT_DIR/stage-audio/02-voice/files/ovos-systemd-dinkum-listener $HOME/.local/bin/
    cp $SCRIPT_DIR/stage-phal/01-user/files/ovos-systemd-phal $HOME/.local/bin/
    echo $sudoPW | sudo -S cp $SCRIPT_DIR/stage-phal/02-admin/files/ovos-systemd-admin-phal /usr/libexec

    chmod +x $HOME/.local/bin/ovos-systemd*
    echo $sudoPW | sudo -S chmod +x /usr/libexec/ovos-systemd-admin-phal

    # sdnotify is required
    pip3 install sdnotify

    # install the service files
    if [[ ! -d $HOME/.config/systemd/user ]]; then
        mkdir -p $HOME/.config/systemd/user
    fi
    cp $SCRIPT_DIR/stage-core/01-ovos-core/files/ovos.service $HOME/.config/systemd/user/
    cp $SCRIPT_DIR/stage-core/01-ovos-core/files/ovos-skills.service $HOME/.config/systemd/user/
    cp $SCRIPT_DIR/stage-core/02-messagebus/files/ovos-messagebus.service $HOME/.config/systemd/user/
    cp $SCRIPT_DIR/stage-audio/01-speech/files/ovos-audio.service $HOME/.config/systemd/user/
    cp $SCRIPT_DIR/stage-audio/02-voice/files/ovos-dinkum-listener.service $HOME/.config/systemd/user/
    cp $SCRIPT_DIR/stage-phal/01-user/files/ovos-phal.service $HOME/.config/systemd/user/
    echo $sudoPW | sudo -S cp $SCRIPT_DIR/stage-phal/02-admin/files/ovos-admin-phal.service /etc/systemd/system/

    for f in $HOME/.config/systemd/user/*.service ; do
        sed -i s,/usr/libexec,/home/ovos/.local/bin,g $f
        # extend the timeouts
        # sed -i s/=1m/=2m/g $f
    done

    if [[ $enabled == "YES" ]]; then
        echo
        echo "Enabling service files"
        echo
        echo $sudoPW | sudo -S loginctl enable-linger $USER
        systemctl --user enable ovos
        systemctl --user enable ovos-messagebus
        systemctl --user enable ovos-dinkum-listener
        systemctl --user enable ovos-audio
        systemctl --user enable ovos-skills
        systemctl --user enable ovos-phal
        echo $sudoPW | sudo -S systemctl enable ovos-admin-phal
        systemctl --user daemon-reload
        echo $sudoPW | sudo -S systemctl daemon-reload
    fi

    cd $SCRIPT_DIR
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

    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-weather
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-hello-world

    # common query
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-ddg
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-wolfie
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-wikipedia

    # fallback
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-fallback-chatgpt

    # OCP
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-news
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-somafm
    pip3 install ${PIP_EDITABLE} ${OVOS_SOURCE}/skill-ovos-youtube-music

    # fun
    pip3 install git+https://github.com/JarbasSkills/skill-icanhazdadjokes

    # Here is where to include your local skills
    if [[ ! -d $HOME/.local/share/mycroft/skills ]]; then
        mkdir -p $HOME/.local/share/mycroft/skills
    fi

    echo
    echo "Done installing extra skills"
    echo
    }

############################################################################################
echo
echo "This file will install ovos-core to this device"
echo "using the latest commits from github."
echo
echo "First lets setup some things."
echo


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

read -p "Do you want a local git clone of all the source (y/N): " want_source
if [[ $want_source == y* || $want_source == Y* ]]; then
    want_source="YES"
    PIP_EDITABLE="-e"
    echo
    OVOS_SOURCE="$HOME/ovos-src"
    read -ep "What directory should the source be cloned to: " -i $OVOS_SOURCE OVOS_SOURCE
    echo
else
    want_source="NO"
    OVOS_SOURCE="git+https://github.com/OpenVoiceOS"
fi
read -p "Do you want to install systemd files (Y/n): " systemd
if [[ -z "$systemd" || $systemd == y* || $systemd == Y* ]]; then
    systemd="YES"
    echo
    read -s -p "Enter your $USER password: " sudoPW
    echo
    echo
    read -p "Do you want to automatically start the ovos services? (Y/n): " enabled
    if [[ -z "$enabled" || $enabled == y* || $enabled == Y* ]]; then
        enabled="YES"
    fi
fi
echo
read -p "Are you using a ramdisk at /ramdisk/mycroft? (Y/n): " ram_disk
if [[ -z "$ram_disk" || $ram_disk == y* || $ram_disk == Y* ]]; then
    ram_disk="YES"
fi
echo
OVOS_EXTRA_SKILL_REPOS=
read -p "Would you like to install extra skills to match the downloadable image? (Y/n): " extra_skills
if [[ -z "$extra_skills" || $extra_skills == y* || $extra_skills == Y* ]]; then
    extra_skills="YES"
    OVOS_EXTRA_SKILL_REPOS="skill-ovos-weather skill-ovos-hello-world skill-ovos-ddg skill-ovos-wolfie skill-ovos-wikipedia skill-ovos-fallback-chatgpt skill-ovos-news skill-ovos-somafm skill-ovos-youtube-music"
fi
echo
echo "We are now ready to install OVOS"
echo
read -p "Type 'Y' to start install (any other key aborts): " install

if [[ $install != Y* && $install != y* ]]; then
    exit 0
fi

# update your system
echo $sudoPW | sudo -S apt update -y
echo $sudoPW | sudo -S apt upgrade -y

if [[ ! -d $HOME/.local/bin ]]; then
    mkdir -p $HOME/.local/bin
fi
PATH=$HOME/.local/bin:$PATH

if [[ $want_source == "YES" ]]; then
    get_src
fi

install_core

# in preparation for someday asking the location of the ramdisk and putting it in
if [[ $ramdisk != "YES" ]]; then
    sed -i /"logs"/,+4d $HOME/.config/mycroft/mycroft.conf
fi

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
    sleep 1
    echo $sudoPW | sudo -S systemctl start ovos-admin-phal
else
    echo
    echo "You can start the ovos services with 'systemctl --user start ovos'"
    echo
fi
echo ""
echo "1. Consider creating an .asoundrc and check your microphone with alsamixer, arecord, and aplay."
echo ""
echo "2. You can find documentation at https://openvoiceos.github.io/community-docs/install_raspbian/"
echo ""
echo "3. You can find pre-built OVOS/PI images at https://ovosimages.ziggyai.online/raspbian/"
echo ""
echo "4. After a reboot $HOME/.local/bin will be added to your path and give you access to the ovos command line utilities."
echo ""
echo "Enjoy your OVOS device"

exit 0

