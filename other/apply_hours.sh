#!/bin/bash

timer=$1
main=/usr/share/harbour-themepacksupport
echo $timer > $main/service/hours

echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.

[Timer]
OnBootSec=0
OnCalendar=*-*-* '$timer'
Persistent=true

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer

if [[ "$(sed -n 2p $main/themepacksupport.cfg)" =~ "1" ]]; then
    systemctl daemon-reload
else
    systemctl enable harbour-themepacksupport.timer
    systemctl start harbour-themepacksupport.timer
    systemctl enable harbour-themepacksupport.service
    systemctl start harbour-themepacksupport.service
    sed -i "s/.*tps_service.*/tps_service='1'/" $main/themepacksupport.cfg
fi
