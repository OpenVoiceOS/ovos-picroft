git clone https://github.com/foundObjects/zram-swap
cd zram-swap
./install.sh
cd ..
rm -rf zram-swap

# Pulse setup
# Comment out `suspend_on_idle` from both system.pa and default.pa
sed -i "s\load-module module-suspend-on-idle\#load-module module-suspend-on-idle\g" /etc/pulse/default.pa
sed -i "s\load-module module-suspend-on-idle\#load-module module-suspend-on-idle\g" /etc/pulse/system.pa
sed -i "s\load-module module-udev-detect\load-module module-udev-detect tsched=0\g" /etc/pulse/system.pa

# anonymous auth for PA
sed -i 's/^load-module module-native-protocol-unix/load-module module-native-protocol-unix auth-anonymous=1/' /etc/pulse/system.pa
# set default sample rate
sed -i 's/^; default-sample-rate = 44100/default-sample-rate = 44100/' /etc/pulse/daemon.conf
echo '# Edit boot configuration settings in /boot/config.txt'
# Uncomment all of these to enable the optional hardware interfaces
sed -i 's/^#dtparam=i2c_arm=on/dtparam=i2c_arm=on/' /boot/config.txt
sed -i 's/^#dtparam=i2s=on/dtparam=i2s=on/' /boot/config.txt
sed -i 's/^#dtparam=spi=on/dtparam=spi=on/' /boot/config.txt
# Comment out the following to disable audio (loads snd_bcm2835)
sed -i 's/^dtparam=audio=on/#dtparam=audio=on/' /boot/config.txt
# Add the following lines at the bottom:

cat >> /boot/config.txt << EOF

# Disable Bluetooth, it interferes with serial port
dtoverlay=pi3-disable-bt
dtoverlay=pi3-miniuart-bt

# Enable Mark 1 soundcard drivers
dtoverlay=rpi-proto

# Change gpu memory
gpu_mem=16

# Obvious
disable_splash=1

# Speed things up a bit
[pi3]

force_turbo=1
boot_delay=1

[all]

EOF
