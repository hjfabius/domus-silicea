#include <SoftwareSerial.h>
#define SSID "HJ_HOME"
#define PASS "8082808280"
#define IP "192.168.0.10" // thingspeak.com
SoftwareSerial dbgSerial(10, 11); // RX, TX

float tempC;
int reading;
int tempPin = 0;



void setup() {

    //Analog reference set to 1.1 V
    analogReference(INTERNAL);

  
    // put your setup code here, to run once:
    dbgSerial.begin(9600);
    //dbgSerial.setTimeout(4000);
    Serial.begin(9600); //can't be faster than 19200 for softserial
    Serial.println("HJ_INO - ESP8266 ");

    //test if the module is ready
    dbgSerial.println("AT+RST");

    for(int i=0;i<10;i++)
    {
        Serial.print(".");
        delay(100);
    }
    if (dbgSerial.find("ready"))
    {
        Serial.println("Module is ready");
    }
    else
    {
        Serial.println("Module have no response.");
        while (1);
    }
    delay(1000);
    //connect to the wifi
    boolean connected = false;
    for (int i = 0; i < 5; i++)
    {
      if (connectWiFi())
      {
        connected = true;
        break;
      }
    }
    if (!connected) {
      while (1);
    }
    delay(5000);

    //print the ip addr
    dbgSerial.println("AT+CIFSR");
    Serial.println("ip address:");
    while (dbgSerial.available())
    Serial.write(dbgSerial.read());
    //set the single connection mode
    dbgSerial.println("AT+CIPMUX=0");
}

void loop() {
  // put your main code here, to run repeatedly:
    reading = analogRead(tempPin);
    tempC = reading / 9.31;
    Serial.println(tempC);
    delay(1000);

}


boolean connectWiFi()
{
    
    dbgSerial.println("AT+CWLAP");
    while (dbgSerial.available())
    Serial.write(dbgSerial.read());
    
    
    dbgSerial.println("AT+CWMODE=1");
    String cmd = "AT+CWJAP=\"";
    cmd += SSID;
    cmd += "\",\"";
    cmd += PASS;
    cmd += "\"";
    Serial.println(cmd);
    dbgSerial.println(cmd);
    delay(2000);
    if (dbgSerial.find("OK"))
    {
        Serial.println("OK, Connected to WiFi.");
        return true;
    } 
    else
    {
        Serial.println("Can not connect to the WiFi.");
        return false;
    }
}

