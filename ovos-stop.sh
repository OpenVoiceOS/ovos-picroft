#!/bin/bash

systemctl --user stop ovos
sleep 1
sudo systemctl stop ovos-admin-phal
#$sudoPW | sudo -S systemctl start ovos-admin-phal

exit 0

