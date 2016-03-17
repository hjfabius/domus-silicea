#include <SoftwareSerial.h>
#include <espduino.h>
#include <mqtt.h>

SoftwareSerial debugPort(2, 3); // RX, TX
ESP esp(&Serial, &debugPort, 4);
MQTT mqtt(&esp);
boolean wifiConnected = false;

void wifiCb(void* response)
{
	uint32_t status;
	RESPONSE res(response);

	if(res.getArgc() == 1) 
	{
		res.popArgs((uint8_t*)&status, 4);
		if(status == STATION_GOT_IP) 
		{
			debugPort.println("WIFI CONNECTED");
			mqtt.connect("192.168.0.10", 1883, false);
			wifiConnected = true;
			//or mqtt.connect("host", 1883); /*without security ssl*/
		} else {
			wifiConnected = false;
			mqtt.disconnect();
		}

	}
}

void mqttConnected(void* response)
{
	debugPort.println("Connected");
	mqtt.subscribe("/DEBUG/IN");
	mqtt.publish("/DEBUG/OUT", "ESPDUINO - MQTT - v3 - Connected");

}

void mqttDisconnected(void* response)
{

}

void mqttData(void* response)
{
        char strBuffer[100];
    
	RESPONSE res(response);

	debugPort.print("Received: topic=");
	String topic = res.popString();
        topic.toCharArray(strBuffer, 100);
	debugPort.println(topic);
	mqtt.publish("/DEBUG/OUT/TOPIC", strBuffer);

	debugPort.print("data=");
	String data = res.popString();
        data.toCharArray(strBuffer, 100);
	debugPort.println(data);
	mqtt.publish("/DEBUG/OUT/DATA", strBuffer);

	
}

void mqttPublished(void* response)
{

}

void setup() 
{
	Serial.begin(19200);
	debugPort.begin(19200);
	debugPort.println("ARDUINO: debug port setup");
	debugPort.println("ARDUINO: Enable ESP");
	esp.enable();
	delay(500);
	debugPort.println("ARDUINO: Reset ESP");
	esp.reset();
	delay(500);
	debugPort.println("ARDUINO: Wait ESP to be ready");
	while(!esp.ready());

	debugPort.println("ARDUINO: setup mqtt client");
	if(!mqtt.begin("DVES_duino", "", "", 120, 1)) 
	{
		debugPort.println("ARDUINO: fail to setup mqtt");
		while(1);
	}


	debugPort.println("ARDUINO: setup mqtt lwt");
	mqtt.lwt("/lwt", "offline", 0, 0); //or mqtt.lwt("/lwt", "offline");

	/*setup mqtt events */
	debugPort.println("ARDUINO: setup mqtt events");
	mqtt.connectedCb.attach(&mqttConnected);
	mqtt.disconnectedCb.attach(&mqttDisconnected);
	mqtt.publishedCb.attach(&mqttPublished);
	mqtt.dataCb.attach(&mqttData);

	/*setup wifi*/
	debugPort.println("ARDUINO: setup wifi");
	esp.wifiCb.attach(&wifiCb);

	esp.wifiConnect("WIFI_SSID","WIFI_PWD");


	debugPort.println("ARDUINO: system started");
	mqtt.publish("/DEBUG/OUT", "ARDUINO: system started");
}

void loop() {
	esp.process();
	if(wifiConnected) 
	{

	}
}
