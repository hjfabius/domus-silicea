#!/bin/bash
echo $(date + "%T") >> /opt/openhab/logs/openhab_start.log
echo "openhab_boot.sh - start" >> /opt/openhab/logs/openhab_start.log

echo "Download rrd4j files from google" >> /opt/openhab/logs/openhab_start.log
cd /opt/openhab/etc/rrd4j/

echo "Files in folder openhab/etc/rrd4j/: $(ls | wc -l)" >> /opt/openhab/logs/openhab_start.log
filecount=$(ls | wc -l)
while [ $filecount -eq 0 ]
do
	echo "Trying synchronization" >> /opt/openhab/logs/openhab_start.log
	/usr/local/bin/gdrive pull -no-prompt -fix-clashes >> /opt/openhab/logs/openhab_start.log
	sleep 1
	filecount=$(ls | wc -l)
	echo "Files in folder openhab/etc/rrd4j/: $(ls | wc -l)" >> /opt/openhab/logs/openhab_start.log
done

sudo chown -R openhab:openhab /opt/openhab
sudo touch *


echo "openhab_boot.sh - end" >> /opt/openhab/logs/openhab_start.log