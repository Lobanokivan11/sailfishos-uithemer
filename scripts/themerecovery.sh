#!/bin/bash

icons=$1
fonts=$2
sounds=$3

main=/usr/share/harbour-themepacksupport

if [ "$icons" = 1 ]; then
    echo "reinstalling icons"
    $main/icon-reinstall.sh
fi

if [ "$fonts" = 1 ]; then
    echo "reinstalling fonts"
    $main/font-restore.sh
    pkcon repo-set-data jolla refresh-now true
    pkcon install --allow-reinstall -y sailfish-fonts
fi

if [ "$sounds" = 1 ]; then
    echo "reinstalling sounds"
    $main/sound-restore.sh
    pkcon repo-set-data jolla refresh-now true
    pkcon install --allow-reinstall -y jolla-ambient-sound-theme
fi
