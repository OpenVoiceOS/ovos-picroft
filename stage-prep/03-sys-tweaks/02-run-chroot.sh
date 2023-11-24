git clone https://github.com/foundObjects/zram-swap
cd zram-swap
./install.sh
cd ..
rm -rf zram-swap

dpkg-reconfigure --frontend noninteractive locales
locale-gen

cat >> /boot/firmware/config.txt << EOF

disable_splash=1

[pi3]

force_turbo=1
boot_delay=1

[all]

EOF
