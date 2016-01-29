/*
-------------How to wire Arduino to Smart meter using RJ11 cable-------------
Note: make sure to place a small resistor between between 5V & ground. Current from an Arduino output pin is 40mA, while 30mA is allowed on the P1 port.
Yellow to pin 9 (TX on meter, RX on arduino)
Red to ground	(Yeah... illogical)
Black to pin 4 or 5V (5V, also counter-intuitive)
-------------Example P1 telegram----------------------------
/ISk5\2ME382-1003
0-0:96.1.1(4B414C37303035303739393336333132)
1-0:1.8.1(00053.950*kWh)	-> Used Low Tariff
1-0:1.8.2(00081.586*kWh)	-> Used High Tariff
1-0:2.8.1(00003.303*kWh)	-> Supplied Low Tariff
1-0:2.8.2(00009.299*kWh)	-> Supplied High Tariff
0-0:96.14.0(0002)		-> Current Tariff
1-0:1.7.0(0000.03*kW)		-> Current Usage
1-0:2.7.0(0000.00*kW)
0-0:17.0.0(0999.00*kW)		-> Limit / Useless
0-0:96.3.10(1)			-> Vendor specific
0-0:96.13.1()			-> Vendor specific
0-0:96.13.0()			-> Vendor specific
!
*/


#define BUFSIZE 512
const int RTSpin =  13;
int incomingByte = 0;
char buffer[BUFSIZE];	// Overkill
int counter=0;
int timer=0;

void setup () {
	Serial.begin(9600);
	
	pinMode(RTSpin, OUTPUT);



}

void loop ()
{
    digitalWrite(RTSpin, HIGH);
    delay(100);
    digitalWrite(RTSpin, LOW);
    delay(100);

    
    byte cmd[] = {0x2F,0x3F,0x21,0x0D,0x0A}; // query the meter for data "/?!"+<13><10>
    Serial.write (cmd,5);
    
    byte a;
    while (Serial.available() > 0)
    {
        a = Serial.read() & 0x7F; // cheap way of converting from 8N1 to 7E1
        char b = a; // convert serial byte to ASCII character
    }

}
    

