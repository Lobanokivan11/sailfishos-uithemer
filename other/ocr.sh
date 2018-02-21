#!/bin/bash

main=/usr/share/harbour-themepacksupport

$main/restore_dpr.sh
$main/restore_iz.sh
$main/restore_adpi.sh
$main/preun_dpr.sh
$main/icon-restore.sh
$main/graphic-restore.sh
$main/font-restore.sh
$main/sound-restore.sh
