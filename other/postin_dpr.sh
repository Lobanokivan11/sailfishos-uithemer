#!/bin/bash

if [ -f /etc/dconf/db/vendor.d/locks/silica-configs.txt ]; then
	mv /etc/dconf/db/vendor.d/locks/silica-configs.txt /usr/share/sailfishos-uithemer/backup/silica-configs.txt.bk
fi

if [ -f /etc/dconf/db/vendor.d/locks/ui-configs.txt ]; then
	mv /etc/dconf/db/vendor.d/locks/ui-configs.txt /usr/share/sailfishos-uithemer/backup/ui-configs.txt.bk
fi

dconf update
