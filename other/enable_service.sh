#!/bin/bash

main=/usr/share/harbour-themepacksupport

systemctl enable harbour-themepacksupport.timer
systemctl start harbour-themepacksupport.timer
systemctl enable harbour-themepacksupport.service
systemctl start harbour-themepacksupport.service
sed -i "s/.*tps_service.*/tps_service='1'/" $main/themepacksupport.cfg
