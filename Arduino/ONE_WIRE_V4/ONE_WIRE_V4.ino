#include "Arduino.h"
#include "LowLevel.h"
#include "OneWireSlave.h"

// This is the pin that will be used for one-wire data (depending on your arduino model, you are limited to a few choices, because some pins don't have complete interrupt support)
// On Arduino Uno, you can use pin 2 or pin 3
Pin oneWireData(2);

Pin led(13);

// This is the ROM the arduino will respond to, make sure it doesn't conflict with another device
//const byte owROM[7] = { 0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02 };
//const byte owROM[]    = {0x28, 0xF2, 0x27, 0xD6, 0x05, 0x00, 0x00, 0x96};
const byte owROM[]    = {0x28, 0xB2, 0x8B, 0xA0, 0x06, 0x00, 0x00, 0xB4};


// This sample emulates a DS18B20 device (temperature sensor), so we start by defining the available commands
const byte DS18B20_START_CONVERSION = 0x44;
const byte DS18B20_READ_SCRATCHPAD = 0xBE;
const byte DS18B20_WRITE_SCRATCHPAD = 0x4E;

// TODO:
// - handle configuration (resolution, alarms)

enum DeviceState
{
	DS_WaitingReset,
	DS_WaitingCommand,
	DS_ConvertingTemperature,
	DS_TemperatureConverted,
};
volatile DeviceState state = DS_WaitingReset;

// scratchpad, with the CRC byte at the end
volatile byte scratchpad[9];

volatile unsigned long conversionStartTime = 0;

// This function will be called each time the OneWire library has an event to notify (reset, error, byte received)
void owReceive(OneWireSlave::ReceiveEvent evt, byte data);

void setup()
{
        Serial.begin(9600);
        Serial.println("DOMUS_SILICEA - OneWire - Version 1");

	led.outputMode();
	led.writeLow();

	// Setup the OneWire library
	OneWire.setReceiveCallback(&owReceive);
	OneWire.begin(owROM, oneWireData.getPinNumber());

        Serial.println("Slave started.");
}

void loop()
{
	delay(10);

	//cli();//disable interrupts
	//sei();//enable interrupts
}

void owReceive(OneWireSlave::ReceiveEvent evt, byte data)
{
        //Serial.println("OneWireSlave::ReceiveEvent");
        //Serial.println("ReceiveEvent::evt" + evt);
        //Serial.println("byte data   ::data" + data);
	switch (evt)
	{
	    case OneWireSlave::RE_Byte:
                 Serial.println("OneWireSlave::RE_Byte");
        	 break;

    	    case OneWireSlave::RE_Reset:
                 //Serial.println("OneWireSlave::RE_Reset:");
        	 break;
    
            case OneWireSlave::RE_Error:
                 //Serial.println("OneWireSlave::RE_Error");
        	 break;
	}
}
