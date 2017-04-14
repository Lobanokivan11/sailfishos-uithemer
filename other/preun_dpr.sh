#!/bin/bash

if [ -f /usr/share/sailfishos-uithemer/backup/silica-configs.txt.bk ]; then
	mv /usr/share/sailfishos-uithemer/backup/silica-configs.txt.bk /etc/dconf/db/vendor.d/locks/silica-configs.txt
fi

if [ -f /usr/share/sailfishos-uithemer/backup/ui-configs.txt.bk ]; then
	mv /usr/share/sailfishos-uithemer/backup/ui-configs.txt.bk /etc/dconf/db/vendor.d/locks/ui-configs.txt
fi

dconf update
