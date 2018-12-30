#!/bin/bash

choice=$1
w1=$2
main=/usr/share/harbour-themepacksupport

function font-changer {

if [ -d /usr/share/harbour-themepack-$choice/font ]; then
        while [ ! -s /usr/share/harbour-themepack-$choice/font/$w1.ttf ]; do
                echo " "
                ls /usr/share/harbour-themepack-$choice/font | sed 's/\(.*\)\..*/\1/'
                read -p "Please enter the default font weight for Sailfish OS and press enter: " w1
        done
        $main/font-run.sh -f $choice -s $w1
        echo "done!"; sleep 1
fi
# If Android support is installed
if [ -d /opt/alien/system/fonts ]; then
if [ -d /usr/share/harbour-themepack-$choice/font ]; then
        if [ -s /usr/share/harbour-themepack-$choice/font/Regular.ttf ]; then
                if [ -s /usr/share/harbour-themepack-$choice/font/Light.ttf ]; then
                        $main/font-run.sh -f $choice -a Regular -d Light
                else
                        $main/font-run.sh -f $choice -a Regular -d Regular
                fi
        elif [ -s /usr/share/harbour-themepack-$choice/font/Light.ttf ]; then
                $main/font-run.sh -f $choice -a Light -d Light
        else
                echo "No fonts suitable for Android found"
        fi
fi
fi

}

if [ "$(ls $main/backup/font)" -o "$(ls $main/backup/font-droid)" ]; then
        $main/font-restore.sh
        $main/font-backup.sh
        font-changer
else
        $main/font-backup.sh
        font-changer
fi
