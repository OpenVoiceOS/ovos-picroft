# script to clean up a local manual install of OVOS

# stop the ovos-processes
systemctl --user stop ovos

# exit on error... We may need to run this script again and we don't want
# to delete anything before it will never be used again
set -e

# get the current directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

read -s -p "Please enter your $USER password: " sudoPW

# look up defaults in ./config/ovos/manual_install.env
[[ -e ~/.config/ovos/manual_install.env ]] && . ~/.config/ovos/manual_install.env
BINDIR=$OVOS_VENV/bin

# remove any downloaded source files
if [[ $want_source == y* || $want_source == Y* ]]; then
   echo "Removing " $OVOS_SOURCE
   rm -fr $OVOS_SOURCE
fi

# remove log files
echo "Removing log files."
rm -fr $HOME/.local/state/mycroft

echo "Removing $HOME/.local/share/mycroft."
rm -fr $HOME/.local/share/mycroft
rm -fr $HOME/.local/share/precise-lite
rm -fr $HOME/.local/share/OpenVoiceOS

rm -fr .cache/mycroft

# remove the ovos venv environment
echo "Removing $OVOS_VENV."
rm -fr $OVOS_VENV

# remove configuration files
echo "Removing $HOME/.config/mycroft."
rm -fr $HOME/.config/mycroft
rm -fr $HOME/.config/OpenVoiceOS

#echo "Removing $HOME/.source/mycroft."
#rm -fr $HOME/.source/mycroft

echo "Removing any nltk data."
rm -fr $HOME/nltk_data

# clean up systemd files
echo "Removing systemd files."
rm -f ${BINDIR}/ovos-systemd-skills
rm -f ${BINDIR}/ovos-systemd-messagebus
rm -f ${BINDIR}/ovos-systemd-audio
rm -f ${BINDIR}/ovos-systemd-dinkum-listener
rm -f ${BINDIR}/ovos-systemd-phal
echo $sudoPW | sudo -S rm -f /usr/libexec/ovos-systemd-admin-phal
#
rm -fr $HOME/.config/systemd/ovos.service.wants
rm -f $HOME/.config/systemd/user/ovos*.service
echo $sudoPW | sudo -S rm -f /etc/systemd/system/ovos-admin-phal.service

# do this last (it's helpful in debugging this script)
echo "Removing $HOME/.config/ovos"
rm -fr $HOME/.config/ovos
rm -fr $HOME/.local/share/OpenVoiceOS

echo "Removed everything but $SCRIPT_DIR... Goodbye!"
#cd ..
#rm -fr $SCRIPT_DIR

