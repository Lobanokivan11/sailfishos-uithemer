#!/bin/bash

systemctl enable harbour-themepacksupport.timer
systemctl start harbour-themepacksupport.timer
systemctl enable harbour-themepacksupport.service
systemctl start harbour-themepacksupport.service
