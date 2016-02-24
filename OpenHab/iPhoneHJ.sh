#!/bin/bash
declare -a DEVICES
hping3 -2 -c 10 -p 5353 -i u1 192.168.0.12 -q >/dev/null 2>&1 
DEVICES=`arp -an | awk '{print $4}'`
CHECK="AA:BB:CC:DD:EE:FF"
if [[ ${DEVICES[*]} =~ $CHECK ]]
then
echo "Present"
else
echo "Absent"
fi
