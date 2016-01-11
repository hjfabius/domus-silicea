#!/bin/bash
date >> /opt/openhab/logs/openhab_start.log
echo "openhab_boot.sh - start" >> /opt/openhab/logs/openhab_start.log
cd /opt/openhab/etc/rrd4j/

echo "Chack that online files are recent enough" >> /opt/openhab/logs/openhab_start.log
intDelta=999999
while [ $intDelta -gt 600 ]
do

   strDate=`sudo gdrive list -long | egrep -o "[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}" | head -n1`
   echo "Date found: $strDate"  >> /opt/openhab/logs/openhab_start.log

   strTime=`sudo gdrive list -long | egrep -o "[[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}" | head -n1`
   echo "Time found: $strTime"  >> /opt/openhab/logs/openhab_start.log

   datGDrive=`date -d "$strDate $strTime"`
   datNow=`date`
   intGDrive=`date -d "$strDate $strTime" +%s`
   intNow=`date +%s`
   intDelta=`expr $intNow - $intGDrive`

   echo "Sysdate:    $datNow"  >> /opt/openhab/logs/openhab_start.log
   echo "GDrive:     $datGDrive"  >> /opt/openhab/logs/openhab_start.log
   echo "Delta:      $intDelta seconds"  >> /opt/openhab/logs/openhab_start.log

done


echo "Download rrd4j files from google" >> /opt/openhab/logs/openhab_start.log

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

#sudo chown -R openhab:openhab /opt/openhab

echo "Download" >> last_refresh.log
date >> last_refresh.log
sudo chown -R openhab:openhab /opt/openhab
touch *


echo "openhab_boot.sh - end" >> /opt/openhab/logs/openhab_start.log
