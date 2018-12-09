#!/bin/bash

main=/usr/share/harbour-themepacksupport
iconpack=$(<$main/icon-current)

echo "reapply icons" $iconpack

$main/icon-restore.sh
$main/icon-backup.sh
$main/icon-run.sh $iconpack
pack=/usr/share/harbour-themepack-$iconpack

if [[ -d $pack/overlay && "$(ls $pack/overlay)" ]]; then

    echo "apply overlay"
    $main/icon-overlay.sh $iconpack

fi
