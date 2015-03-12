status="'$(who am i | sed 's/.*(\(.*\))/\1/')' connected via SSH"

url=https://api.thingspeak.com/update?api_key=H7BWI5JFUU2OZP1I\&status=$status

curl "$url" -o "/tmp/publishSomeoneConnected.log"
