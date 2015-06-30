#include <SPI.h>
#include <MySensor.h>  
#include <DHT.h>  
#include <avr/sleep.h>    // Sleep Modes

#define CHILD_ID_HUM 0
#define CHILD_ID_TEMP 1
#define CHILD_ID_PIR 2
#define HUMIDITY_SENSOR_DIGITAL_PIN 8
#define SLEEP_IN_MS 30000  // Sleep time between reads (in milliseconds)
//#define SLEEP_IN_MS 86400000 // 1 day

#define DIGITAL_INPUT_SENSOR 2   // The digital input you attached your motion sensor.  (Only 2 and 3 generates interrupt!)
#define INTERRUPT DIGITAL_INPUT_SENSOR-2 // Usually the interrupt = pin -2 (on uno/nano anyway)



MySensor gw;
DHT dht;
int     lastBatLevel;
float   lastTemp;
float   lastHum;
boolean lastPirTripped;
boolean metric = true; 
MyMessage msgHum(CHILD_ID_HUM, V_HUM);
MyMessage msgTemp(CHILD_ID_TEMP, V_TEMP);
MyMessage msgPir(CHILD_ID_PIR, V_TRIPPED);

void setup()  
{ 
  gw.begin();
  dht.setup(HUMIDITY_SENSOR_DIGITAL_PIN, dht.DHT11); 
  pinMode(DIGITAL_INPUT_SENSOR, INPUT);      // sets the motion sensor digital pin as input

  // Send the Sketch Version Information to the Gateway
  gw.sendSketchInfo("EASYIOT_TEMP", "3.0");

  // Register all sensors to gw (they will be created as child devices)
  gw.present(CHILD_ID_HUM, S_HUM);
  gw.present(CHILD_ID_TEMP, S_TEMP);
  gw.present(CHILD_ID_PIR, S_MOTION);
}

void loop()      
{  
  // Read digital motion value
  boolean pirTripped = digitalRead(DIGITAL_INPUT_SENSOR) == HIGH; 
  if (pirTripped != lastPirTripped) {
    lastPirTripped = pirTripped;
    gw.send(msgPir.set(pirTripped?"1":"0"));
    Serial.print("PIR: ");
    Serial.println(pirTripped);
  }
  
  
  delay(dht.getMinimumSamplingPeriod());

  float temperature = dht.getTemperature();
  if (isnan(temperature)) {
      Serial.println("Failed reading temperature from DHT");
  } else if (temperature != lastTemp) {
    lastTemp = temperature;
    gw.send(msgTemp.set(temperature, 1));
    Serial.print("Temperature: ");
    Serial.println(temperature);
  }
  
  float humidity = dht.getHumidity();
  if (isnan(humidity)) {
      Serial.println("Failed reading humidity from DHT");
  } else if (humidity != lastHum) {
      lastHum = humidity;
      gw.send(msgHum.set(humidity, 1));
      Serial.print("Humidity: ");
      Serial.println(humidity);
  }

  int batLevel = getBatteryLevel();
  if (lastBatLevel != batLevel)
  {
    lastBatLevel = batLevel;
    gw.sendBatteryLevel(batLevel);    
    Serial.print("Battery Level: ");
    Serial.println(batLevel);
    
  }

  // Sleep until interrupt comes in on motion sensor. Send update every 30 seconds. 
  gw.sleep(INTERRUPT,CHANGE, SLEEP_IN_MS);
}


// Battery measure
int getBatteryLevel () 
{
  int results = (readVcc() - 2000)  / 10;   

  if (results > 100)
    results = 100;
  if (results < 0)
    results = 0;
  return results;
} // end of getBandgap


// when ADC completed, take an interrupt 
EMPTY_INTERRUPT (ADC_vect);

long readVcc() {
  long result;
  // Read 1.1V reference against AVcc
  ADMUX = _BV(REFS0) | _BV(MUX3) | _BV(MUX2) | _BV(MUX1);
  delay(2); // Wait for Vref to settle
  noInterrupts ();
  // start the conversion
  ADCSRA |= _BV (ADSC) | _BV (ADIE);
  set_sleep_mode (SLEEP_MODE_ADC);    // sleep during sample
  interrupts ();
  sleep_mode (); 
  // reading should be done, but better make sure
  // maybe the timer interrupt fired 
  while (bit_is_set(ADCSRA,ADSC));
  result = ADCL;
  result |= ADCH<<8;
  result = 1126400L / result; // Back-calculate AVcc in mV

  return result;
}

