git clone https://github.com/foundObjects/zram-swap
cd zram-swap
./install.sh
cd ..
rm -rf zram-swap

cat >> /boot/config.txt << EOF

gpu_mem=16
disable_splash=1

[pi3]

force_turbo=1
boot_delay=1

[all]

EOF
