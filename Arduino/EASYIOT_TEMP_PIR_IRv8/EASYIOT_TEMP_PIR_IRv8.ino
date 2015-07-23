#include <SPI.h>
#include <MySensor.h>  
#include <DHT.h>  
#include <avr/sleep.h>    // Sleep Modes
#include <IRLib.h>
#include <DomusSiliceaLogging.h>


#define NODE_ID          1

#define CHILD_ID_HUM     0
#define CHILD_ID_TEMP    1
#define CHILD_ID_PIR     2
#define CHILD_ID_IR_TX   3

#define SKETCH_NAME      "EASYIOT_TEMP_PIR_IR"
#define SKETCH_VERSION   "8.0"

#define BATTERY_SLEEP_MS                 3600000UL    // Sleep time between reads (in milliseconds)
#define BATTERY_MAX_SILENT_MS            86400000UL   // Force trasmission every day even if value does not change



#define DHT_SENSOR_DIGITAL_INPUT     8
#define DHT_SLEEP_MS                 120000UL      // Sleep time between reads (in milliseconds)
#define DHT_MAX_SILENT_MS            3600000UL    // Force trasmission every hour even if value does not change
//#define SLEEP_IN_MS 86400000                    // 1 day

#define PIR_SENSOR_DIGITAL_INPUT     2            // The digital input you attached your motion sensor.  (Only 2 and 3 generates interrupt!)
#define INTERRUPT                    PIR_SENSOR_DIGITAL_INPUT-2 // Usually the interrupt = pin -2 (on uno/nano anyway)
#define PIR_DISABLED_MS              30000UL      // Disable PIR for XX milliseconds (i.e. if a IR signal is trasmitted)

#define IR_TX_SENSOR_DIGITAL_OUTPUT  3            // The digital output you attached your ir led.  Reference constant, not used in the code
#define IR_TX_SLEEP_MS               5000UL       // Sleep time between reads (in milliseconds)

#define LED_STRIP_ON                 1111
#define LED_STRIP_OFF                9999

#define DOMUSSILICEA_LOGLEVEL        DOMUSSILICEA_LOG_LEVEL_VERBOSE


DomusSiliceaLogging  m_objLogger = DomusSiliceaLogging();



MySensor  gw;
MyMessage msgHum      (CHILD_ID_HUM,  V_HUM);
MyMessage msgTemp     (CHILD_ID_TEMP, V_TEMP);
MyMessage msgPir      (CHILD_ID_PIR,  V_TRIPPED);
DHT       dht;
IRsend    irsend;

unsigned int      m_blnBatteryPowered = true;

unsigned long     m_lngLastCheckDHT       = -DHT_SLEEP_MS;    // To force initial trasmission after reboot
float             m_fltLastTemperature    = 0;
unsigned long     m_lngLastTxTemperature  = 0;
float             m_fltLastHumidity       = 0;
unsigned long     m_lngLastTxUmidity      = 0;


int               m_intLastBatteryLevel   = 0;
unsigned long     m_lngLastCheckBattery   = -BATTERY_SLEEP_MS;     // To force initial trasmission after reboot
unsigned long     m_lngLastTxBatteryLevel = 0;

boolean           m_blnLastPIRTripped;
unsigned long     m_lngNextCheckPir;

int               m_intLastIRLed = 0;

/****************************************************************************/
/* Reset                                                                    */
/****************************************************************************/
//void(* resetFunc) (void) = 0;//declare reset function at address 0


/****************************************************************************/
/* SETUP                                                                    */
/****************************************************************************/
void setup()  
{ 
    m_objLogger.Init(DOMUSSILICEA_LOGLEVEL, 115200L);
    
    gw.begin(mySensorsIncomingMessage, NODE_ID, !m_blnBatteryPowered); /*If battery powered, not work how repeater*/
    gw.sendSketchInfo(SKETCH_NAME, SKETCH_VERSION);
    
    dht.setup(DHT_SENSOR_DIGITAL_INPUT, dht.DHT11); 
    //pinMode(PIR_SENSOR_DIGITAL_INPUT, INPUT);   
    
    
    // Register all sensors to gw (they will be created as child devices)
    gw.present(CHILD_ID_HUM,      S_HUM);
    gw.present(CHILD_ID_TEMP,     S_TEMP);
    //gw.present(CHILD_ID_PIR,      S_MOTION);
    //gw.present(CHILD_ID_IR_TX,    S_DIMMER);
    //gw.present(CHILD_ID_IR_TX,    S_LIGHT);

    // Read current value of light sensor
    //gw.request(CHILD_ID_IR_TX,    V_DIMMER);
    //gw.request(CHILD_ID_IR_TX,    V_LIGHT);
    
    // If powered by battery, than every hour (BATTERY_SLEEP_MS) a check of the battery level is performed
    //m_blnBatteryPowered = (readVcc() < 3300);                    

}


/****************************************************************************/
/* LOOP                                                                     */
/****************************************************************************/
void loop()      
{  


    //updatePIR();    
    updateTemperatureAndHumidity();
    updateBatteryLevel();


    //gw.process();

    // Sleep until interrupt comes in on motion sensor. Send update every 30 seconds. 
    //gw.sleep(INTERRUPT,CHANGE, DHT_SLEEP_MS);
    
    //Or in case you don't have PIR
    gw.sleep(DHT_SLEEP_MS);

   
   //If millis is reaching the overflow (50 days, one hour before will reset the chip)
   /*
   if(millis()> 4291367295) 
   {
       resetFunc();
   } 
   */
}



/****************************************************************************/
/* Callback function MySensor                                               */
/****************************************************************************/
void mySensorsIncomingMessage(const MyMessage &message) 
{
    m_objLogger.Debug("Gateway:  Sensor=%d   Type=%d   Value=%d"CR, message.sensor, message.type, message.getInt());
    if  ((message.sensor == NODE_ID) && (message.type==V_LIGHT))
    {
        m_objLogger.Info("Gateway:  Type=V_LIGHT  Value=%d"CR, message.getInt());
        
        switch(message.getInt())
        {
            case 1:
                setLedStripValue(LED_STRIP_ON);
                break;
            case 0:
                setLedStripValue(LED_STRIP_OFF);
                break;
            default:
                m_objLogger.Error("Gateway:  Value not managed"CR);
                break;
        }
        
    }
    else if  ((message.sensor == NODE_ID) && (message.type==V_DIMMER))
    {
        m_objLogger.Info("Gateway:  Type=V_DIMMER  Value=%d"CR, message.getInt());
        setLedStripValue( message.getInt() );
    }
    else
    {
        m_objLogger.Error("Gateway:  Type not managed=%d"CR, message.type);
    }
}


/****************************************************************************/
/* When ADC completed, take an interrupt                                    */
/****************************************************************************/
EMPTY_INTERRUPT (ADC_vect);

/****************************************************************************/
/* Convert Battery VCC in percentage and send to gateway                    */
/****************************************************************************/
void updateBatteryLevel () 
{
    if(m_blnBatteryPowered == true)
    {
        if(millis()-m_lngLastCheckBattery > BATTERY_SLEEP_MS)
        {
            m_lngLastCheckBattery = millis();
            
            int intBatteryLevel = (readVcc() - 2000)  / 10;   
                    
            if (intBatteryLevel > 100)
                intBatteryLevel = 100;
            if (intBatteryLevel < 0)
                intBatteryLevel = 0;
                
            m_objLogger.Info("Battery: %d"CR, intBatteryLevel);
        
            if (
                    (m_intLastBatteryLevel != intBatteryLevel)  ||
                    (millis() - m_lngLastTxBatteryLevel > BATTERY_MAX_SILENT_MS )
               )
            {
                    m_lngLastTxBatteryLevel = millis();
                    m_intLastBatteryLevel = intBatteryLevel;
                    gw.sendBatteryLevel(intBatteryLevel);    
            }

        }
    }    
}


/****************************************************************************/
/* Measure Battery Level on the VCC pin                                     */
/****************************************************************************/
long readVcc() 
{
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


/****************************************************************************/
/* Get Temperature and Humidity and, if different from previous one,        */
/* send to gateway                                                          */
/****************************************************************************/
void updateTemperatureAndHumidity()
{
    if(millis()-m_lngLastCheckDHT > DHT_SLEEP_MS)
    {
        m_lngLastCheckDHT = millis();
        updateTemperature();    
        updateHumidity();   
    
    
        // Sleep until interrupt comes in on motion sensor. Send update every 30 seconds. 
        // gw.sleep(INTERRUPT, CHANGE, SLEEP_IN_MS);
    }
}


/****************************************************************************/
/* Get Temperature and if different from previous one send to gateway       */
/****************************************************************************/
void updateTemperature() 
{

    float fltTemperature = dht.getTemperature();
    if (isnan(fltTemperature)) 
    {
        m_objLogger.Error("Temperature: %s"CR, dht.getStatusString());
    } 
    else 
    {
        if (fltTemperature > 100)
            fltTemperature = 100;
        if (fltTemperature < -40)
            fltTemperature = -40;
                
        m_objLogger.Info("Temperature: %d"CR, (int) fltTemperature);        
        
        if (
                (fltTemperature != m_fltLastTemperature)  || 
                (millis() - m_lngLastTxTemperature > DHT_MAX_SILENT_MS)
           )
        {
            m_lngLastTxTemperature = millis();
            m_fltLastTemperature = fltTemperature;
            gw.send(msgTemp.set(fltTemperature, 1));
        }
    }
}


/****************************************************************************/
/* Get Humidity and if different from previous one send to gateway       */
/****************************************************************************/
void updateHumidity() 
{
    float fltHumidity = dht.getHumidity();
    if (isnan(fltHumidity)) 
    {
        m_objLogger.Error("Humidity: %s"CR, dht.getStatusString());
    } 
    else 
    {
        if (fltHumidity > 100)
            fltHumidity = 100;
        if (fltHumidity < 0)
            fltHumidity = 0;

        m_objLogger.Info("Humidity: %d"CR, (int) fltHumidity);        
        if (
                (fltHumidity != m_fltLastHumidity) || 
                (millis() - m_lngLastTxUmidity > DHT_MAX_SILENT_MS)
           )
        {
            m_lngLastTxUmidity = millis();
            m_fltLastHumidity = fltHumidity;
            gw.send(msgHum.set(fltHumidity, 1));
        }
    }
}


/****************************************************************************/
/* Get PIR and if different from previous one send to gateway               */
/****************************************************************************/
void updatePIR() 
{
    //In case of overflow (approx 50 days) it will stop PIR check
    if(millis()>m_lngNextCheckPir)
    {
        // Read digital motion value
        boolean blnPIRTripped = digitalRead(PIR_SENSOR_DIGITAL_INPUT) == HIGH; 
        if (blnPIRTripped != m_blnLastPIRTripped) 
        {
            m_blnLastPIRTripped = blnPIRTripped;
            gw.send(msgPir.set(blnPIRTripped?"1":"0"));

        m_objLogger.Info("PIR: %s"CR, (blnPIRTripped?"Motion Detected":"Ok") );        
        }
    }

}


/****************************************************************************/
/* Update Led Strip                                                         */
/****************************************************************************/
void setLedStripValue(int a_NewValue)
{
    int i;
    
    if(a_NewValue == LED_STRIP_ON)
    {
        m_objLogger.Info("Led Strip: On"CR);
        irsend.send(NEC,0xF7C03F, 32);   //Led Strip - On
        delay(150);
        irsend.send(NEC,0xF7E01F, 32);   //Led Strip - White
    }
    else if(a_NewValue == LED_STRIP_OFF)
    {
        m_objLogger.Info("Led Strip: Off"CR);
        irsend.send(NEC,0xF740BF, 32); //Led Strip - Off
    }
    else //dimmer value 
    {
        //gw.send(msgLedStrip.set( (a_NewValue == 0?0:1), false));
        
        if(a_NewValue >0)
        {
            m_objLogger.Info("Led Strip: On"CR);
            irsend.send(NEC,0xF7C03F, 32);   //Led Strip - On
            delay(150);
            irsend.send(NEC,0xF7E01F, 32);   //Led Strip - White
            delay(150);
        }
        
        if (m_intLastIRLed == 0) 
        {
            
            m_objLogger.Info("Led Strip: Decreasing Light "CR);
            for(i=0; i<20; i++)
            {
                irsend.send(NEC,0xF7807F, 32);   //Led Strip - Decrease Light
                delay(100);
            }
            delay(150);
        }

        m_objLogger.Info("Led Strip: Adjusting Light "CR);
        for(i=0; i< abs(a_NewValue-m_intLastIRLed) ; i++)
        {
            irsend.send(NEC,  (a_NewValue>m_intLastIRLed?0xF700FF:0xF7807F)  , 32);   
            delay(100);
        }
        m_intLastIRLed = a_NewValue;
        
                
    }

    m_lngNextCheckPir = millis() + PIR_DISABLED_MS;


}


