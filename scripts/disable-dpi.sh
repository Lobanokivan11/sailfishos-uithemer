#!/bin/bash

main=/usr/share/harbour-themepacksupport

echo "disabling dpi"

$main/restore_dpr.sh
$main/restore_adpi.sh
$main/restore_iz.sh
$main/disable-dpi.sh

echo "done"

exit 0
