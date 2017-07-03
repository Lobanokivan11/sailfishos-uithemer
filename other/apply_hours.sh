#!/bin/bash

timer=$1
main=/usr/share/harbour-themepacksupport
echo $timer > $main/service/hours

echo '[Unit]
Description=Update icon theme via Theme pack support.

[Timer]
OnBootSec=0
OnCalendar=*-*-* '$timer'
Persistent=true

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer

systemctl daemon-reload
