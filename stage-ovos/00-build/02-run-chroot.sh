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

sudo ln -s /usr/lib/systemd/user/ovos.service /usr/lib/systemd/user/default.target.wants/

sudo ln -s /usr/lib/systemd/user/ovos-audio.service /usr/lib/systemd/user/ovos.service.wants/
sudo ln -s /usr/lib/systemd/user/ovos-messagebus.service /usr/lib/systemd/user/ovos.service.wants/
sudo ln -s /usr/lib/systemd/user/ovos-phal.service /usr/lib/systemd/user/ovos.service.wants/
sudo ln -s /usr/lib/systemd/user/ovos-skills.service /usr/lib/systemd/user/ovos.service.wants/
sudo ln -s /usr/lib/systemd/user/ovos-voice.service /usr/lib/systemd/user/ovos.service.wants/

sudo ln -s /usr/lib/systemd/system/ovos-admin-phal.service /etc/systemd/system/default.target.wants/

sudo ln -s /usr/lib/systemd/system/NetworkManager.service /etc/systemd/system/default.target.wants/
