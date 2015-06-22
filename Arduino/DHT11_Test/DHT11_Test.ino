#include <SoftwareSerial.h>
#include <dht.h>

#define dht_dpin A0 //no ; here. Set equal to channel sensor is on

dht DHT;
SoftwareSerial dbgSerial(10, 11); // RX, TX

void setup(){
    dbgSerial.begin(9600); //can't be faster than 19200 for softserial
    delay(300);//Let system settle
    dbgSerial.println("Humidity and temperature\n\n");
    delay(700);//Wait rest of 1000ms recommended delay before
    //accessing sensor
}//end "setup()"

void loop()
{
    //This is the "heart" of the program.
    DHT.read11(dht_dpin);
    
    dbgSerial.print("Current humidity = ");
    dbgSerial.print(DHT.humidity);
    dbgSerial.print("%  ");
    dbgSerial.print("temperature = ");
    dbgSerial.print(DHT.temperature); 
    dbgSerial.println("C  ");
    delay(800);//Don't try to access too frequently... in theory
    //should be once per two seconds, fastest,
    //but seems to work after 0.8 second.
}// end loop()
