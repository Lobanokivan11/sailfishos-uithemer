#!/bin/bash

iconpack=$1
main=/usr/share/harbour-themepacksupport

# Check if a backup has been performed
        if [ "$(ls $main/backup/jolla)" -o "$(ls $main/backup/native)" -o "$(ls $main/backup/apk)" -o "$(ls $main/backup/dyncal)" -o "$(ls $main/backup/dynclock)" ]; then
                $main/icon-restore.sh
                $main/icon-backup.sh
                $main/icon-run.sh $iconpack
        else
                $main/icon-backup.sh
                $main/icon-run.sh $iconpack
        fi
