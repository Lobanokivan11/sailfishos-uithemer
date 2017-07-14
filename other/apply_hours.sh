#!/bin/bash

timer=$1
main=/usr/share/harbour-themepacksupport
echo $timer > $main/service/hours

    case "$timer" in
    "30")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=*:0/30
Persistent=true
[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "1")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=1hr
Persistent=true
[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "2")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=2hr
Persistent=true
[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "3")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=3hr
Persistent=true
[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "6")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=6hr
Persistent=true
[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;
    "12")  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=12hr
Persistent=true
[Install]
WantedBy=timers.target' > /etc/systemd/system/harbour-themepacksupport.timer ;;



    * )  echo '[Unit]
Description=Timer for updating icon theme via Theme pack support.
[Timer]
OnBootSec=0
OnCalendar=*-*-* '$timer'
Persistent=true
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
