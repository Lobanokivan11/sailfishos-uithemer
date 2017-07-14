#!/bin/bash

timer=$1
main=/usr/share/harbour-themepacksupport
echo $timer > $main/service/hours

    case "$timer" in
    "30")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=*-*-* *:0/30
Persistent=true
OnActiveSec=30m

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "1")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=hourly
Persistent=true
OnActiveSec=1h

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "2")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=00:00
Persistent=true
OnActiveSec=2h

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "3")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=00:00
Persistent=true
OnActiveSec=3h

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "6")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=00:00
Persistent=true
OnActiveSec=6h

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "12")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=00:00
Persistent=true
OnActiveSec=12h

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;



    * )  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=*-*-* '$timer'
Persistent=true
OnActiveSec=24h

[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
		esac

if [[ "$(sed -n 2p $main/themepacksupport.cfg)" =~ "1" ]]; then
    systemctl daemon-reload
else
    systemctl enable harbour-themepacksupport.timer
    systemctl start harbour-themepacksupport.timer
    systemctl enable harbour-themepacksupport.service
    systemctl start harbour-themepacksupport.service
    sed -i "s/.*tps_service.*/tps_service='1'/" $main/themepacksupport.cfg
fi
