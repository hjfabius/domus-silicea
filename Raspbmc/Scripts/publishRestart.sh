#!/bin/bash

url=https://api.thingspeak.com/update?key=H7BWI5JFUU2OZP1I\&status=Restarted


#echo $url

curl "$url" -o "/tmp/publishRestart.log"
