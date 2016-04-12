#include "Arduino.h"
#include "LowLevel.h"
#include "OneWireSlave.h"

// Defines to access to Low and High bytes
#define Lo(x)   ((x) & 0xFF) 
#define Hi(x)   (((x)>>8) & 0xFF) 

// This is the pin that will be used for one-wire data (depending on your arduino model, you are limited to a few choices, because some pins don't have complete interrupt support)
// On Arduino Uno, you can use pin 2 or pin 3
Pin oneWireData(2);
#define brightnessPin 0

// This is the ROM the arduino will respond to, make sure it doesn't conflict with another device, 0x28 - DS18B20 identificator
const byte owROM[] = {0x28, 0xF2, 0x27, 0xD6, 0x05, 0x00, 0x00, 0x96};


// 0 - Low Byte Temperature 
// 1 - High Byte Temperature
// 2-7 - reserved
// 8 - CRC8
byte SCRATCHPAD[] = {0x00, 0x00, 0x4B, 0x46, 0x7F, 0xFF, 0x05, 0x10, 0x00};

int brightness = 0;

// This function will be called each time the OneWire library has an event to notify (reset, error, byte received)
void owReceive(OneWireSlave::ReceiveEvent evt, byte data);

void setup() {
	// Setup the OneWire library
	OneWire.setReceiveCallback(&owReceive);
	OneWire.begin(owROM, oneWireData.getPinNumber());
  Serial.begin(9600);
}

void loop() {
  Serial.print("brightness=");
  Serial.println(brightness);
  delay(5000);
  
	cli();//disable interrupts

	sei();//enable interrupts
}

void owReceive(OneWireSlave::ReceiveEvent evt, byte data) {
	switch (evt) {
    case OneWireSlave::RE_Reset:
      break;
    case OneWireSlave::RE_Byte:
      // Start measuring brightness
      if (data == 0x44) {
        brightness = analogRead(brightnessPin);     
        // Add brightness to the SCRATCHPAD
        SCRATCHPAD[0] = Lo(brightness*16);
        SCRATCHPAD[1] = Hi(brightness*16);
        // Add CRC8 to the SCRATCHPAD
        SCRATCHPAD[8] = OneWire.crc8(SCRATCHPAD,8);  
      }
    
      // Read Scratchpad [BEh] command
      if (data == 0xBE) {
        // Send SCRATCHPAD 9 byte with brightness and CRC
        for (byte i = 8, j = 1; j<=9; i--, j++) {
          OneWire.write(&SCRATCHPAD[i], j, NULL);
        }
      }        
      break;
    case OneWireSlave::RE_Error:
		  break;
	  default:
		;
	}
}
