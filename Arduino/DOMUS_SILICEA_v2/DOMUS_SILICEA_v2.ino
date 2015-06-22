//////////////////////////////////////////////////////////
// Wifi Connectivity
//////////////////////////////////////////////////////////
#define SSID "HJ_HOME"
#define PASS "8082808280"

//////////////////////////////////////////////////////////
// Software serial
//////////////////////////////////////////////////////////
#include <SoftwareSerial.h>
SoftwareSerial dbgSerial(10, 11); // RX, TX

//////////////////////////////////////////////////////////
// Temperature and humidity
//////////////////////////////////////////////////////////
#include <dht.h>
#define dht_dpin A0 //no ; here. Set equal to channel sensor is on
dht DHT;

//////////////////////////////////////////////////////////
// PIR
//the time we give the sensor to calibrate (10-60 secs according to the datasheet)
int intCalibrationTime = 10;
int pirPin = 2;    //the digital pin connected to the PIR sensor's output


//////////////////////////////////////////////////////////
// ThingsSpeaks
//////////////////////////////////////////////////////////
#define IP "184.106.153.149" // thingspeak.com
#define UPDATE_INTERVAL 10000
String GET = "GET /update?key=5NRS4PZDLHTPHCFK";
String GET_TEMP = "GET /update?key=5NRS4PZDLHTPHCFK&field1=";
String GET_HUMIDITY = "GET /update?key=5NRS4PZDLHTPHCFK&field2=";
String GET_MOVEMENT = "GET /update?key=5NRS4PZDLHTPHCFK&field3=";
String TWITTER      = "hjdomussilicea";
String TWITTER_MESSAGE = "Qualcuno si muove ...";

int counter = 0;


//////////////////////////////////////////////////////////
void setup()
{
    // Open serial communications and wait for port to open:
    Serial.begin(9600);
    Serial.setTimeout(4000);
    dbgSerial.begin(9600); //can't be faster than 19200 for softserial
    dbgSerial.println("DOMUS_SILICEA - Arduino - ESP8266 - DHT11");

    setupWIFI();
    setupPIR();
}


//////////////////////////////////////////////////////////
void loop()
{
    double pirStatus;
    boolean blnUpdateStatus;
    DHT.read11(dht_dpin);
    pirStatus = getPIRStatus();
    blnUpdateStatus = updateThingSpeak(DHT.temperature, DHT.humidity, pirStatus);
    if(!blnUpdateStatus)
    {
      setupWIFI();
    }
    delay(UPDATE_INTERVAL);
}


//////////////////////////////////////////////////////////
double getPIRStatus()
{
    int intPIRStatus = 0;
    for(int i=0; i<5; i++)
    {
      if(digitalRead(pirPin) == HIGH)
      {
          intPIRStatus++;
      }
      delay(100);
    }
    
    if(intPIRStatus >=3)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

//////////////////////////////////////////////////////////
boolean updateThingSpeak(double dblTemp, double dblHumidity, double dblPIRStatus)
{
    dbgSerial.print("Updating Temperature: " + String(dblTemp) + "C                Humidity: " + String(dblHumidity) + "%           PIR: " + String(dblPIRStatus));

    String cmd = "AT+CIPSTART=\"TCP\",\"";
    cmd += IP;
    cmd += "\",80";
    Serial.println(cmd);
    delay(2000);
    if(Serial.find("Error")){
       dbgSerial.println("Error");
       return false;
    }
    cmd = GET;
    cmd += "&field1=" + String(dblTemp);
    cmd += "&field2=" + String(dblHumidity);
    cmd += "&field3=" + String(dblPIRStatus);
    if(dblPIRStatus==1)
    {
       cmd += "&twitter=" + TWITTER + "&tweet=" + TWITTER_MESSAGE + " " + counter;
       counter++;
    }
    
    cmd += "\r\n";
    Serial.print("AT+CIPSEND=");
    Serial.println(cmd.length());
    if(Serial.find(">")){
        Serial.print(cmd);
    }else{
        Serial.println("AT+CIPCLOSE");
    }
    dbgSerial.println("Done");
    return true;
}

//////////////////////////////////////////////////////////
void setupPIR()
{
      pinMode(pirPin, INPUT);
      digitalWrite(pirPin, LOW);
      //give the sensor some time to calibrate
      dbgSerial.print("Calibrating PIR sensoor ");
      for(int i = 0; i < intCalibrationTime; i++){
          Serial.print(".");
          delay(1000);
      }
      dbgSerial.println(" done");
      dbgSerial.println("PIR Sensor Active");
      delay(50);
      
}


//////////////////////////////////////////////////////////
boolean setupWIFI()
{
    dbgSerial.print("Configuring ESP8266 Module ");

    //test if the module is ready
    Serial.println("AT+RST");

    for(int i=0;i<10;i++)
    {
        dbgSerial.print(".");
        delay(100);
    }
    if (Serial.find("ready"))
    {
        dbgSerial.println("Module is ready");
    }
    else
    {
        dbgSerial.println("Module have no response.");
        delay(1000);
        return false;
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
      delay(1000);
      return false;
    }
    delay(5000);

    //print the ip addr
    Serial.println("AT+CIFSR");
    dbgSerial.println("WIFI Local IP address:");
    while (Serial.available())
    dbgSerial.write(Serial.read());
    //set the single connection mode
    Serial.println("AT+CIPMUX=0");
    
    return true;
}


//////////////////////////////////////////////////////////
boolean connectWiFi()
{
    Serial.println("AT+CWMODE=1");
    String cmd = "AT+CWJAP=\"";
    cmd += SSID;
    cmd += "\",\"";
    cmd += PASS;
    cmd += "\"";
    dbgSerial.println(cmd);
    Serial.println(cmd);
    delay(2000);
    if (Serial.find("OK"))
    {
        dbgSerial.println("OK, Connected to WiFi.");
        return true;
    } 
    else
    {
        dbgSerial.println("Can not connect to the WiFi.");
        return false;
    }
}


