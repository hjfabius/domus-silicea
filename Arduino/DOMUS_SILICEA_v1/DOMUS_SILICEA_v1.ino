#include <SoftwareSerial.h>
#define SSID "HJ_HOME"
#define PASS "8082808280"
#define IP "184.106.153.149" // thingspeak.com
SoftwareSerial dbgSerial(10, 11); // RX, TX


#include <dht.h>
#define dht_dpin A0 //no ; here. Set equal to channel sensor is on
dht DHT;


String GET = "GET /update?key=5NRS4PZDLHTPHCFK";
String GET_TEMP = "GET /update?key=5NRS4PZDLHTPHCFK&field1=";
String GET_HUMIDITY = "GET /update?key=5NRS4PZDLHTPHCFK&field2=";
String GET_MOVEMENT = "GET /update?key=5NRS4PZDLHTPHCFK&field3=";

void setup()
{
    // Open serial communications and wait for port to open:
    Serial.begin(9600);
    Serial.setTimeout(4000);
    dbgSerial.begin(9600); //can't be faster than 19200 for softserial
    dbgSerial.println("DOMUS_SILICEA - Arduino - ESP8266 - DHT11");

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
    Serial.println("AT+CIFSR");
    dbgSerial.println("ip address:");
    while (Serial.available())
    dbgSerial.write(Serial.read());
    //set the single connection mode
    Serial.println("AT+CIPMUX=0");
}


void loop()
{
    DHT.read11(dht_dpin);
    //updateTemp(DHT.temperature);
    //updateHumidity(DHT.humidity);
    updateTemperatureAndHumidity(DHT.temperature, DHT.humidity);
    delay(10000);
}

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



void updateTemp(double dblTemp)
{
    dbgSerial.print("Updating Temperature: " + String(dblTemp) + "C ");

    String cmd = "AT+CIPSTART=\"TCP\",\"";
    cmd += IP;
    cmd += "\",80";
    Serial.println(cmd);
    delay(2000);
    if(Serial.find("Error")){
       dbgSerial.println("Error");
       return;
    }
    cmd = GET_TEMP;
    cmd += String(dblTemp);
    cmd += "\r\n";
    Serial.print("AT+CIPSEND=");
    Serial.println(cmd.length());
    if(Serial.find(">")){
        Serial.print(cmd);
    }else{
        Serial.println("AT+CIPCLOSE");
    }
    dbgSerial.println("Done");
}


void updateTemperatureAndHumidity(double dblTemp, double dblHumidity)
{
    dbgSerial.print("Updating Temperature: " + String(dblTemp) + "C                Humidity: " + String(dblHumidity) + "%   ");

    String cmd = "AT+CIPSTART=\"TCP\",\"";
    cmd += IP;
    cmd += "\",80";
    Serial.println(cmd);
    delay(2000);
    if(Serial.find("Error")){
       dbgSerial.println("Error");
       return;
    }
    cmd = GET;
    cmd += "&field1=" + String(dblTemp);
    cmd += "&field2=" + String(dblHumidity);
    cmd += "\r\n";
    Serial.print("AT+CIPSEND=");
    Serial.println(cmd.length());
    if(Serial.find(">")){
        Serial.print(cmd);
    }else{
        Serial.println("AT+CIPCLOSE");
    }
    dbgSerial.println("Done");
}





void updateHumidity(double dblHumidity)
{
    dbgSerial.print("Updating Humidity: " + String(dblHumidity) + "% ");

    String cmd = "AT+CIPSTART=\"TCP\",\"";
    cmd += IP;
    cmd += "\",80";
    Serial.println(cmd);
    delay(2000);
    if(Serial.find("Error")){
       dbgSerial.println("Error");
       return;
    }
    cmd = GET_HUMIDITY;
    cmd += String(dblHumidity);
    cmd += "\r\n";
    Serial.print("AT+CIPSEND=");
    Serial.println(cmd.length());
    if(Serial.find(">")){
        Serial.print(cmd);
    }else{
        Serial.println("AT+CIPCLOSE");
    }
    dbgSerial.println("Done");
}
