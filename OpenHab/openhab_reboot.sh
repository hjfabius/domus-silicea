#!/bin/bash
echo $(date + "%T") >> /opt/openhab/logs/openhab_stop.log
echo "openhab_reboot.sh - start" >> /opt/openhab/logs/openhab_stop.log

echo "Stopping the service"  >> /opt/openhab/logs/openhab_stop.log
sudo /etc/init.d/openhab stop

echo "Uploading rrd4j files on google"  >> /opt/openhab/logs/openhab_stop.log
cd /opt/openhab/etc/rrd4j/
sudo touch *
/usr/local/bin/gdrive push -no-prompt  >> /opt/openhab/logs/openhab_stop.log

echo "reboot"   >> /opt/openhab/logs/openhab_stop.log
sudo /sbin/reboot

echo "openhab_reboot.sh - end" >> /opt/openhab/logs/openhab_stop.log
