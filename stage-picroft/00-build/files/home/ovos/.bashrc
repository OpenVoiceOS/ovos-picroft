PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '

alias ll='ls -la'

# Hack to make mycroft services enabled and start on first boot
# if [[ -f /home/ovos/first_boot ]]; then
#  systemctl --user enable mycroft
#  systemctl --user enable mycroft-messagebus
#  systemctl --user enable mycroft-audio
#  systemctl --user enable mycroft-voice
#  systemctl --user enable mycroft-phal
#  systemctl --user enable mycroft-skills
#  systemctl --user start mycroft
#
#  rm /home/ovos/first_boot
# fi

######################################################################
# Initialize OpenVoiceOS CLI Environment
######################################################################
source cli_login.sh
