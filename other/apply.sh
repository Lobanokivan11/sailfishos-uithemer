#!/bin/bash

iconpack=$1
main=/usr/share/harbour-themepacksupport

$main/icon-restore.sh
$main/icon-backup.sh
$main/icon-run.sh $iconpack
