#!/bin/bash

systemctl disable harbour-themepacksupport.timer
systemctl stop harbour-themepacksupport.timer
systemctl disable harbour-themepacksupport.service
systemctl stop harbour-themepacksupport.service
sed -i "s/.*tps_service.*/tps_service='0'/" $main/themepacksupport.cfg
