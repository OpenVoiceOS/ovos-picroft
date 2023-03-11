# mimic for offline tts
curl https://forslund.github.io/mycroft-desktop-repo/mycroft-desktop.gpg.key | apt-key add - 2> /dev/null && echo "deb http://forslund.github.io/mycroft-desktop-repo bionic main" | tee /etc/apt/sources.list.d/mycroft-desktop.list
sudo apt update
sudo apt install mimic

# install ncpamixer
cd /home/ovos
git clone https://github.com/fulhax/ncpamixer.git
cd ncpamixer
make
sudo make install
cd ..
rm -rf ncpamixer

# Add file for first boot flag
touch /home/ovos/first_boot
