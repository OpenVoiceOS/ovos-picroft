chown -Rf ovos:ovos /home/ovos

systemctl set-default multi-user.target

systemctl preset-all

su -c "systemctl --user preset-all" --login ovos

su -c "ln -s /ramdisk/mycroft/audio.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/bus.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/skills.log /home/ovos/.local/state/mycroft/" --login ovos
su -c "ln -s /ramdisk/mycroft/voice.log /home/ovos/.local/state/mycroft/" --login ovos
