#!/bin/bash

# Exit on error
# If something goes wrong just stop. The script should be re-runnable
# and it allows the user to see issues at once rather than having
# scroll back and figure out what went wrong.
set -e

# tested with a clean 64 bit installation of Raspbian-Lite

# Define some python groups (these are repository names, not PyPI names!)
# Any group can be disabled by setting the value before running the script
# Eg to skip installing Dinkum
# $ export OVOS_DINKUM_REPOS=""
: ${OVOS_CORE_REPOS:="ovos-backend-client ovos-core ovos-audio ovos-ocp-audio-plugin ovos-messagebus"}
: ${OVOS_DINKUM_REPOS:="ovos-dinkum-listener ovos-vad-plugin-silero ovos-ww-plugin-pocketsphinx ovos-audio-transformer-plugin-ggwave"}
: ${OVOS_PRECISE_LITE_REPOS:="ovos-ww-plugin-precise ovos-ww-plugin-precise-lite ovos-workshop ovos-lingua-franca ovos-vad-plugin-webrtcvad"}
: ${OVOS_STT_REPOS:="ovos-microphone-plugin-sounddevice ovos-stt-plugin-server"}
: ${OVOS_TTS_REPOS:="ovos-tts-plugin-mimic3-server ovos-tts-plugin-mimic ovos-tts-plugin-piper ovos-tts-server-plugin"}
: ${OVOS_EXTRA_REPOS:="ovos-config ovos-utils ovos-bus-client ovos-plugin-manager ovos-cli-client"}
: ${OVOS_PHAL_REPOS:="ovos-PHAL ovos-phal-plugin-connectivity-events ovos-phal-plugin-system ovos-PHAL-plugin-ipgeo ovos-PHAL-plugin-oauth ovos-phal-plugin-alsa"}
: ${OVOS_SKILLS_REPOS:="skill-ovos-volume skill-ovos-fallback-unknown skill-ovos-stop skill-alerts skill-ovos-personal skill-ovos-naptime skill-ovos-date-time"}
: ${OVOS_EXTRA_SKILL_REPOS:="skill-ovos-weather skill-ovos-hello-world skill-ovos-ddg skill-ovos-wolfie skill-ovos-wikipedia skill-ovos-fallback-chatgpt skill-ovos-news skill-ovos-somafm skill-ovos-youtube-music"}

function get_src() {
    mkdir -p ${OVOS_SOURCE}
    pushd ${OVOS_SOURCE}
    echo Cloning source to ${OVOS_SOURCE}
    for p in $OVOS_CORE_REPOS $OVOS_DINKUM_REPOS $OVOS_PRECISE_LITE_REPOS $OVOS_STT_REPOS $OVOS_TTS_REPOS $OVOS_EXTRA_REPOS $OVOS_PHAL_REPOS $OVOS_SKILLS_REPOS $OVOS_EXTRA_SKILL_REPOS; do
	echo Cloning $p
	[[ -d $p ]] || git clone https://github.com/OpenVoiceOS/$p
    done
    popd
}

function install_core (){
    echo "Installing OVOS core"
    echo

    # set up the Raspberry Pi
    echo $sudoPW | sudo -S apt install -y build-essential python3-dev python3-pip python3-venv swig libssl-dev libfann-dev portaudio19-dev libpulse-dev cmake libncurses-dev pulseaudio-utils pulseaudio libsdl2-dev

    # make sure pulseaudio is running
    pulseaudio --check || pulseaudio -D

    # make ggwave from scratch
    if [[ -d $SCRIPT_DIR/ggwave ]]; then
        rm -fr $SCRIPT_DIR/ggwave
    fi

    git clone https://github.com/ggerganov/ggwave --recursive
    cd ggwave && mkdir build && cd build
    sed -i 's/BUILD_SHARED_LIBS_DEFAULT ON/BUILD_SHARED_LIBS_DEFAULT OFF/g' ../CMakeLists.txt
    cmake .. && make

    if [[ ! -d $HOME/.local/bin ]]; then
        mkdir -p $HOME/.local/bin
    fi

    mv bin/* /$HOME/.local/bin/

    # padatious required to support newest ovos-core
    # fann version must be fixed as raspbian libfann-dev is too old for latest
    pip3 install padatious fann2==1.0.7

    # Precise-lite wake-word (ww) cluster
    pip3 install tflite_runtime

    pip3 install PyYAML
    pip3 install PyAudio

    # install text to speech (tts)
    echo $sudoPW | sudo -S apt install -y espeak-ng

    # install phal components

    INSTALL=""
    # install ovos-core
    for p in $OVOS_CORE_REPOS $OVOS_DINKUM_REPOS $OVOS_PRECISE_LITE_REPOS $OVOS_STT_REPOS $OVOS_TTS_REPOS $OVOS_EXTRA_REPOS $OVOS_PHAL_REPOS; do
	INSTALL="$INSTALL ${PIP_EDITABLE} ${OVOS_SOURCE}/$p"
    done
    # Skills cannot be installed as 'editable' as they will not be discovered by importlib.metadata: https://github.com/python/cpython/issues/96144
    for p in $OVOS_SKILLS_REPOS; do
	INSTALL="$INSTALL ${OVOS_SOURCE}/$p"
    done

    # Do all the installs at once to allow pip to sort out dependencies nicely
    echo installing $INSTALL
    pip3 install $INSTALL

    # You can uncomment these lines if the deprecation notices are flooding your logs or slowing the system
    #sed -i '/\@deprecated/d' $HOME/.local/lib/python3.9/site-packages/ovos_utils/fingerprinting.py
    #sed -i '/\@deprecated/d' $HOME/.local/lib/python3.9/site-packages/ovos_utils/configuration.py
    #sed -i '/\@deprecated/d' $HOME/.local/lib/python3.9/site-packages/ovos_utils/ovos_service_api.py
    #sed -i '/\@deprecated/d' $HOME/.local/lib/python3.9/site-packages/ovos_utils/signal.py

    if [[ ! -d $HOME/.config/mycroft ]]; then
        mkdir -p $HOME/.config/mycroft
    fi
    cp $SCRIPT_DIR/stage-core/01-ovos-core/files/mycroft.conf $HOME/.config/mycroft/
    sed -i 's,/home/ovos/.local/share/precise_lite/hey_mycroft.tflite,https://github.com/OpenVoiceOS/precise-lite-models/raw/master/wakewords/en/hey_mycroft.tflite,' $HOME/.config/mycroft/mycroft.conf
    echo $SCRIPT_DIR
    echo
    echo "Done installing OVOS core"
    }

function install_systemd (){
    echo
    echo "Installing systemd files"
    echo

    # install the hook files
    cp $SCRIPT_DIR/stage-core/01-ovos-core/files/ovos-systemd-skills ${BINDIR}/
    cp $SCRIPT_DIR/stage-core/02-messagebus/files/ovos-systemd-messagebus ${BINDIR}/
    cp $SCRIPT_DIR/stage-speech/01-speech/files/ovos-systemd-audio ${BINDIR}/
    cp $SCRIPT_DIR/stage-listener/01-listener/files/ovos-systemd-dinkum-listener ${BINDIR}/
    cp $SCRIPT_DIR/stage-phal/01-user/files/ovos-systemd-phal ${BINDIR}/
    echo $sudoPW | sudo -S cp $SCRIPT_DIR/stage-phal/02-admin/files/ovos-systemd-admin-phal /usr/libexec

    chmod +x ${BINDIR}/ovos-systemd*
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
    cp $SCRIPT_DIR/stage-speech/01-speech/files/ovos-audio.service $HOME/.config/systemd/user/
    cp $SCRIPT_DIR/stage-listener/01-listener/files/ovos-dinkum-listener.service $HOME/.config/systemd/user/
    cp $SCRIPT_DIR/stage-phal/01-user/files/ovos-phal.service $HOME/.config/systemd/user/
    echo $sudoPW | sudo -S cp $SCRIPT_DIR/stage-phal/02-admin/files/ovos-admin-phal.service /etc/systemd/system/

    # Use the venv python to run the scripts
    for f in $HOME/.config/systemd/user/*.service ; do
        sed -i s,/usr/libexec,${BINDIR},g $f
        if [[ $f == "$HOME/.config/systemd/user/ovos.service" ]]; then
            echo "Skip $f"
        else
            sed -i "s,ExecStart=,ExecStart=${OVOS_VENV}/bin/python3 ," $f
            sed -i "s,\%h/.venv/bin/python,," $f
        fi
        # extend the timeouts
        # sed -i s/=1m/=2m/g $f
    done

    echo $sudoPW | sudo -S sed -i "s,/home/ovos/.venv/bin/python,${OVOS_VENV}/bin/python3 ," /etc/systemd/system/ovos-admin-phal.service
    echo $sudoPW | sudo -S sed -i "s,User=ovos,User=$USER ," /etc/systemd/system/ovos-admin-phal.service

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

    INSTALL=""
    # install the OVOS extra skills
    for p in $OVOS_EXTRA_SKILL_REPOS; do
	INSTALL="$INSTALL ${OVOS_SOURCE}/$p"
    done

    # Add some fun
    INSTALL="$INSTALL git+https://github.com/OpenVoiceOS/skill-ovos-icanhazdadjokes"

    # Do all the installs at once to allow pip to sort out dependencies nicely
    pip3 install $INSTALL

    # Here is where to include your local skills
    if [[ ! -d $HOME/.local/share/mycroft/skills ]]; then
        mkdir -p $HOME/.local/share/mycroft/skills
    fi

    echo
    echo "Done installing extra skills"
    echo
    }

############################################################################################

# be sure to run inside a clone of the raspOVOS repo
if [[ ! -d stage_core ]]; then
    echo "This script depends on a copy of the raspOVOS repository."
    read -ep "Would you like to clone it to the current directory? (Y/n): " -i "$fresh_clone" fresh_clone 
    if [[ -z "$fresh_clone" || $fresh_clone == y* || $fresh_clone == Y* ]]; then
	if [[ -d raspOVOS ]]; then
	    echo "A directory called raspOVOS is already present. Please remove or rename it to continue."
	    exit
	fi
	git clone https://github.com/OpenVoiceOS/raspOVOS.git
	cd raspOVOS
	./manual_user_install.sh
    fi
    exit
fi

echo
echo "This file will install ovos-core to this device"
echo "using the latest commits from github."
echo
echo "First lets set up some things."
echo

# Save the config to allow multiple runs without typing too much :)
function save_config() {
    mkdir -p ~/.config/ovos/
    cat <<EOF > ~/.config/ovos/manual_install.env
want_source=$want_source
OVOS_SOURCE=$OVOS_SOURCE
OVOS_VENV=$OVOS_VENV
systemd=$systemd
enabled=$enabled
ram_disk=$ram_disk
extra_skills=$extra_skills
install=$install
EOF
}
# Get defaults from previous run
[[ -e ~/.config/ovos/manual_install.env ]] && . ~/.config/ovos/manual_install.env

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

read -ep "Do you want a local git clone of all the source? (y/N): " -i "$want_source" want_source
if [[ $want_source == y* || $want_source == Y* ]]; then
    want_source="YES"
    PIP_EDITABLE="-e"
    echo
    : ${OVOS_SOURCE:="$HOME/ovos-src"}
    read -ep "What directory should the source be cloned to? " -i "$OVOS_SOURCE" OVOS_SOURCE
    echo
else
    want_source="NO"
    OVOS_SOURCE="git+https://github.com/OpenVoiceOS"
    echo
fi

: ${OVOS_VENV:=$HOME/venv-ovos}
read -ep "What directory should the venv be installed into? " -i $OVOS_VENV OVOS_VENV
echo

read -ep "Do you want to install systemd files? (Y/n): " -i "$systemd" systemd
if [[ -z "$systemd" || $systemd == y* || $systemd == Y* ]]; then
    systemd="YES"
    echo
    read -s -p "Enter your $USER password: " sudoPW
    echo
    echo
    read -ep "Do you want to automatically start the ovos services? (Y/n): " -i "$enabled" enabled
    if [[ -z "$enabled" || $enabled == y* || $enabled == Y* ]]; then
        enabled="YES"
    fi
fi
echo
read -ep "Are you using a ramdisk at /ramdisk/mycroft? (Y/n): " -i "$ram_disk" ram_disk
if [[ -z "$ram_disk" || $ram_disk == y* || $ram_disk == Y* ]]; then
    ram_disk="YES"
fi
echo
read -ep "Would you like to install extra skills to match the downloadable image? (Y/n): " -i "$extra_skills" extra_skills
if [[ -z "$extra_skills" || $extra_skills == y* || $extra_skills == Y* ]]; then
    extra_skills="YES"
fi
save_config # up to this point
echo
echo "We are now ready to install OVOS."
echo
read -ep "Type 'Y' to start install (any other key aborts): " -i "$install" install

if [[ $install != Y* && $install != y* ]]; then
    exit 0
fi
save_config # include the install's yes answer :)

# update your system
echo $sudoPW | sudo -S apt update -y
echo $sudoPW | sudo -S apt upgrade -y

# Ensure the correct packages are installed
echo $sudoPW | sudo -S apt install -y python3-dev python3-pip python3-venv

if [[ ! -d $OVOS_VENV ]]; then
    echo Creating ovos venv
    python3 -mvenv $OVOS_VENV
    $OVOS_VENV/bin/pip3 install --upgrade setuptools wheel pip
    echo
fi
. $OVOS_VENV/bin/activate || {
    echo Failed to activate ovos venv at $OVOS_VENV
    exit 1
}
BINDIR=$OVOS_VENV/bin

if [[ ! -d ${BINDIR} ]]; then
    mkdir -p ${BINDIR}
fi

# Ensure PATH includes BINDIR (but only once)
if ! grep -q ${BINDIR} ~/.bashrc; then
cat <<EOF >> ~/.bashrc
PATH=:\$PATH
PATH=$BINDIR\${PATH//:'$BINDIR':/:}
EOF
fi

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
echo "2. You can find documentation at https://openvoiceos.github.io/community-docs/"
echo ""
echo "3. You can find pre-built OVOS/PI images at https://ovosimages.ziggyai.online/raspbian/development/"
echo ""
echo "4. After a reboot ${BINDIR} will be added to your path and give you access to the ovos command line utilities."
echo ""
echo "Enjoy your OVOS device"

exit 0

