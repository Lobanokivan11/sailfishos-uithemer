#!/bin/bash

iconpack=$1
overlay=$2
main=/usr/share/harbour-themepacksupport

echo "apply icons" $1

$main/icon-restore.sh
$main/icon-backup.sh
$main/icon-run.sh $iconpack

echo $overlay

if [ "$overlay" = 1 ]; then
    echo "apply overlay"
    $main/icon-overlay.sh $iconpack
else
    echo "skip overlay"
fi

touch /usr/share/applications/*.desktop
