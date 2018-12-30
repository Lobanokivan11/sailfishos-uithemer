#!/bin/bash

icons=$1
fonts=$2

main=/usr/share/harbour-themepacksupport

if [ "$icons" = 1 ]; then
    echo "restoring icons"
    $main/icon-restore.sh
fi

if [ "$fonts" = 1 ]; then
    echo "restoring fonts"
    $main/font-restore.sh
fi
