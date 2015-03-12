#!/bin/bash
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))

#echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"

url="$cpuTemp1"."$cpuTempM"

url=https://api.thingspeak.com/update?api_key=H7BWI5JFUU2OZP1I\&field1=$url

#echo $url

curl "$url" -o "/tmp/publishCPUTemp.log"
