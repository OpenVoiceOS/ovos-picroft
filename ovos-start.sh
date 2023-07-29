#!/bin/bash

systemctl --user start ovos
sleep 1
sudo systemctl start ovos-admin-phal
#$sudoPW | sudo -S systemctl start ovos-admin-phal

exit 0

