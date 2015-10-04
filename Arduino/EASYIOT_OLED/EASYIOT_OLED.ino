/*********************************************************************
This is an example for our Monochrome OLEDs based on SSD1306 drivers

  Pick one up today in the adafruit shop!
  ------> http://www.adafruit.com/category/63_98

This example is for a 128x64 size display using I2C to communicate
3 pins are required to interface (2 I2C and one reset)

Adafruit invests time and resources providing this open source code, 
please support Adafruit and open-source hardware by purchasing 
products from Adafruit!

Written by Limor Fried/Ladyada  for Adafruit Industries.  
BSD license, check license.txt for more information
All text above, and the splash screen must be included in any redistribution
*********************************************************************/

#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

#define OLED_RESET 4
Adafruit_SSD1306 display(OLED_RESET);

int i = 0;

#define DIGITAL_INPUT_SENSOR 3  // The digital input you attached your light sensor.  (Only 2 and 3 generates interrupt!)
#define INTERRUPT DIGITAL_INPUT_SENSOR-2 // Usually the interrupt = pin -2 (on uno/nano anyway)
#define PULSE_FACTOR 10000       // Nummber of blinks per KWH of your meeter
#define MAX_WATT 15000          // Max watt value to report. This filetrs outliers.
volatile unsigned long pulseCount = 0;   
double ppwh = ((double)PULSE_FACTOR)/1000; // Pulses per watt hour
volatile unsigned long watt = 0;
volatile unsigned long old_watt = 0;
volatile unsigned long lastBlink = 0;
volatile unsigned long interval = 0;


unsigned long lastMilli = 0;

void setup()   {                
  Serial.begin(9600);


  // by default, we'll generate the high voltage from the 3.3v line internally! (neat!)
  //display.begin(SSD1306_SWITCHCAPVCC, 0x3D);  // initialize with the I2C addr 0x3D (for the 128x64)
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  // initialize with the I2C addr 0x3D (for the 128x64)
  // init done
  
  // Clear the buffer.
  display.clearDisplay();

  // text display tests
  display.setTextSize(1);
  display.setTextColor(BLACK, WHITE);
  display.setCursor(0,0);
  display.println("    EASYIOT_OLED!    ");
  display.setTextColor(WHITE, BLACK);

  display.display();


  attachInterrupt(INTERRUPT, onPulse, RISING);

  lastMilli = millis();

}


void loop() 
{
    if(millis()-lastMilli >1000)
    {
        lastMilli = millis();
        
        display.setCursor(0,10);
        display.print("Counter:   ");
        display.print(i);
        display.print("           ");
    
        display.setCursor(0,20);
        display.print("WattHour:  ");
        if( (micros() - lastBlink)  > 3000000) 
        {
            display.print(0);
        }
        else if (watt>((unsigned long)MAX_WATT))
        {
            display.print("MAX");
        }
        else
        {
            display.print(watt);
        }
        display.print("           ");
        
        display.setCursor(0,30);
        display.print("Pulse:     ");
        display.print(pulseCount);
        display.print("           ");
                
        display.display();

        i++;
    }    
}

void onPulse()     
{ 
    unsigned long newBlink = micros();  
    interval = newBlink-lastBlink;
    if (interval<10000L) 
    { // Sometimes we get interrupt on RISING
      return;
    }
    watt = (3600000000.0 /interval) / ppwh;
    lastBlink = newBlink;
  
    pulseCount++;
}


