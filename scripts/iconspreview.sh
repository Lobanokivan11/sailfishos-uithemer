#!/bin/bash

iconpack=$1
main=/usr/share/harbour-themepacksupport

cd /usr/share/harbour-themepack-$iconpack/
find jolla native apk overlay -type f -name "*.png" | shuf -n 9 |\
    montage @- -tile x3 -geometry 128x128+15+15 -background none $main/tmp/iconspreview.png
