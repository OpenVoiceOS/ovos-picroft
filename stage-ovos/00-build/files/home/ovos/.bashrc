PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '

alias ll='ls -la'

# Hack to make mycroft services enabled and start on first boot
if [[ -f /home/ovos/first_boot ]]; then

 systemctl --user enable mycroft.service
 systemctl --user enable mycroft-messagebus.service
 systemctl --user enable mycroft-audio.service
 systemctl --user enable mycroft-voice.service
 systemctl --user enable mycroft-phal.service
 systemctl --user enable mycroft-admin-phal.service
 systemctl --user enable mycroft-skills.service
 systemctl --user start mycroft.service

 rm /home/ovos/first_boot
fi

######################################################################
# Initialize OpenVoiceOS CLI Environment
######################################################################
source cli_login.sh
