#!/bin/bash -e

# Install required daemon

git clone https://github.com/mikebrady/nqptp.git
cd nqptp
autoreconf -fi
./configure --with-systemd-startup
make
make install
cd ..
rm -rf nqptp

git clone https://github.com/mikebrady/shairport-sync.git
cd shairport-sync
autoreconf -fi
./configure --sysconfdir=/etc --with-pulse \
  --with-soxr --with-avahi --with-ssl=openssl --with-systemd --with-airplay-2
make
make install
cd ..
sed -i "s|WantedBy=multi-user.target|WantedBy=default.target|" /lib/systemd/system/shairport-sync.service
rm -rf shairport-sync
