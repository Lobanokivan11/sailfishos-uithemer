#!/bin/bash

main=/usr/share/harbour-themepacksupport

$main/font-restore.sh

pkcon repo-set-data jolla refresh-now true
pkcon install --allow-reinstall -y sailfish-fonts
