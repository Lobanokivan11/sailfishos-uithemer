#!/bin/bash

icons=$1
fonts=$2

main=/usr/share/harbour-themepacksupport

if [ "$icons" = 1 ]; then
    echo "reinstalling icons"
    $main/icon-reinstall.sh
fi

if [ "$fonts" = 1 ]; then
    echo "restoring fonts"
    $main/font-restore.sh
    pkcon repo-set-data jolla refresh-now true
    pkcon install --allow-reinstall -y sailfish-fonts
fi
