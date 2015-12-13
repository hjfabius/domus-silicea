#define NODE_ID          6

#define CHILD_ID_HUM     0
#define CHILD_ID_TEMP    1
#define CHILD_ID_PIR     2
#define CHILD_ID_IR_TX   3
#define CHILD_ID_WATT    4


#define SKETCH_NAME      "DS_WATT"
#define SKETCH_VERSION   "11.0"

#define DEEP_SLEEP_MS                300000    // milliseconds = 5 minutes
#define COUNTER_FORCE_SEND_BATTERY      144    // 144*DEEP_SLEEP_MS = 12 hours       
#define COUNTER_FORCE_SEND_TEMPERATURE   24    //  24*DEEP_SLEEP_MS =  2 hours       
#define COUNTER_FORCE_SEND_HUMIDITY      24    //  24*DEEP_SLEEP_MS =  2 hours       

#define BATTERY_POWERED                  true
//#define DHT_SENSOR_DIGITAL_INPUT         8
//#define PIR_SENSOR_DIGITAL_INPUT         2       // The digital input you attached your motion sensor.  (Only 2 and 3 generates interrupt!)
//#define PIR_DISABLED_MS              30000       // Disable PIR for XX milliseconds (i.e. if a IR signal is trasmitted)

//#define IR_SENSOR_DIGITAL_OUTPUT       3       // The digital output you attached your ir led.  Reference constant, not used in the code
#define WATT_SENSOR_DIGITAL_INPUT        3       // The digital input where the module to detect light flash is connected

#define LED_STRIP_ON                  1111
#define LED_STRIP_OFF                 9999

#define DOMUSSILICEA_LOGLEVEL        DOMUSSILICEA_LOG_LEVEL_VERBOSE

/****************************************************************************/
/* Includes                                                                 */
/****************************************************************************/
#include <SPI.h>
#include <avr/sleep.h>    // Sleep Modes
#include <MySensor.h>  
#include <DomusSiliceaLogging.h>

#ifdef DHT_SENSOR_DIGITAL_INPUT
    #include <DHT.h>  
#endif
#ifdef IR_SENSOR_DIGITAL_OUTPUT
    #include <IRLib.h>
#endif

/****************************************************************************/
/* Variables                                                                 */
/****************************************************************************/


DomusSiliceaLogging  m_objLogger = DomusSiliceaLogging();
MySensor             gw;
int                  m_intCounterForceSendBattery        = 0;
int                  m_intLastBatteryLevel               = 0;



#ifdef DHT_SENSOR_DIGITAL_INPUT
    MyMessage        msgHum      (CHILD_ID_HUM,  V_HUM);
    MyMessage        msgTemp     (CHILD_ID_TEMP, V_TEMP);
    DHT              dht;
    int              m_intCounterForceSendTemperature    = 0;
    int              m_intCounterForceSendHumidity       = 0;
    float            m_fltLastTemperature                = 0;
    float            m_fltLastHumidity                   = 0;
#endif

#ifdef PIR_SENSOR_DIGITAL_INPUT
    #define          PIR_INTERRUPT                    PIR_SENSOR_DIGITAL_INPUT-2 // Usually the interrupt = pin -2 (on uno/nano anyway)
    MyMessage        msgPir(CHILD_ID_PIR,  V_TRIPPED);
    boolean          m_blnLastPIRTripped                 = false;
    unsigned long    m_lngNextCheckPir                   = 0;
#endif

#ifdef IR_SENSOR_DIGITAL_OUTPUT
    IRsend           irsend;
    int              m_intLastIRLed                      = 0;
#endif

#ifdef WATT_SENSOR_DIGITAL_INPUT
    MyMessage        msgWatt                          (CHILD_ID_WATT,      V_WATT);
    MyMessage        msgKWH                           (CHILD_ID_WATT,      V_KWH);    
    MyMessage        msgPulseCount                    (CHILD_ID_WATT,      V_VAR1);
    #define          PULSE_FACTOR                     1000                             // Number of blinks per KWH of your meeter
    #define          MAX_WATT                         15000                            // Max watt value to report. This filetrs outliers.
    #define          WATT_INTERRUPT                   WATT_SENSOR_DIGITAL_INPUT-2      // Usually the interrupt = pin -2 (on uno/nano anyway)
    unsigned long    m_lngLastSend;

    unsigned long    SEND_FREQUENCY                     = 5000;                        // Minimum time between send (in milliseconds). We don't wnat to spam the gateway.
    double           m_dblPpwh                          = ((double)PULSE_FACTOR)/1000; // Pulses per watt hour
    boolean          m_blnPcReceived                    = false; 
    volatile unsigned long m_lngPulseCount              = 0;   
    volatile unsigned long m_lngLastBlink               = 0;
    volatile unsigned long m_lngWatt                    = 0;
    unsigned long    m_lngOldPulseCount                 = 0;   
    unsigned long    m_lngOldWatt                       = 0;
    double           m_dblOldKwh;


#endif

/****************************************************************************/
/* SETUP                                                                    */
/****************************************************************************/
void setup()  
{ 
    m_objLogger.Init(DOMUSSILICEA_LOGLEVEL, 9600L);
    //m_objLogger.Debug("Setup - Node Id = %d"CR, NODE_ID);    
    
    //If battery powered, not work how repeater
    gw.begin(mySensorsIncomingMessage, NODE_ID, !BATTERY_POWERED);
    gw.sendSketchInfo(SKETCH_NAME, SKETCH_VERSION);
    
    #ifdef DHT_SENSOR_DIGITAL_INPUT
        m_objLogger.Debug("Setup - DHT_SENSOR_DIGITAL_INPUT"CR);
        dht.setup(DHT_SENSOR_DIGITAL_INPUT, dht.DHT11); 
        gw.present(CHILD_ID_HUM,      S_HUM);
        gw.present(CHILD_ID_TEMP,     S_TEMP);
    #endif
    
    #ifdef PIR_SENSOR_DIGITAL_INPUT
        m_objLogger.Debug("Setup - PIR_SENSOR_DIGITAL_INPUT"CR);
        pinMode(PIR_SENSOR_DIGITAL_INPUT, INPUT);   
        gw.present(CHILD_ID_PIR,      S_MOTION);
    #endif
        
    #ifdef IR_SENSOR_DIGITAL_OUTPUT
        m_objLogger.Debug("Setup - IR_SENSOR_DIGITAL_OUTPUT"CR);
        gw.present(CHILD_ID_IR_TX,    S_DIMMER);
        gw.present(CHILD_ID_IR_TX,    S_LIGHT);
    #endif
    
    #ifdef WATT_SENSOR_DIGITAL_INPUT
        m_objLogger.Debug("Setup - WATT_SENSOR_DIGITAL_INPUT"CR);

        gw.present(CHILD_ID_WATT, S_POWER);
        gw.request(CHILD_ID_WATT, V_VAR1);
        attachInterrupt(WATT_INTERRUPT, onWattPulse, RISING);
        m_lngLastSend=millis();
    #endif
    
    m_objLogger.Debug("Setup - End"CR);       
}


/****************************************************************************/
/* LOOP                                                                     */
/****************************************************************************/
void loop()      
{  
    updateBatteryLevel();

    #ifdef PIR_SENSOR_DIGITAL_INPUT
        updatePIR();    
    #endif
        
    #ifdef DHT_SENSOR_DIGITAL_INPUT
        updateTemperature();    
        updateHumidity();   
    #endif    
    
    #ifdef BATTERY_POWERED
        gw.process();
    #endif    

    #ifdef WATT_SENSOR_DIGITAL_INPUT || WATT_SENSOR_DIGITAL_INPUT
        processWattPulses();
    #endif

    #ifdef PIR_SENSOR_DIGITAL_INPUT
        // Sleep until interrupt comes in on motion sensor. Send update every 30 seconds. 
        gw.sleep(PIR_INTERRUPT,    CHANGE,  DEEP_SLEEP_MS);
    #elsifdef WATT_SENSOR_DIGITAL_INPUT
        //do nothing
    #else
        //Or in case you don't have PIR
        gw.sleep(DEEP_SLEEP_MS);
    #endif
    
        
}



/****************************************************************************/
/* Callback function MySensor                                               */
/****************************************************************************/
void mySensorsIncomingMessage(const MyMessage &message) 
{
    //m_objLogger.Debug("Gateway:  Sensor=%d   Type=%d   Value=%d"CR, message.sensor, message.type, message.getInt());
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
            defat:
                m_objLogger.Error("Gateway:  Value not managed"CR);
                break;
        }
        
    }
    else if  ((message.sensor == NODE_ID) && (message.type==V_DIMMER))
    {
        m_objLogger.Info("Gateway:  Type=V_DIMMER  Value=%d"CR, message.getInt());
        setLedStripValue( message.getInt() );
    }
    else if  ((message.sensor == NODE_ID) && (message.type==V_VAR1))
    {
        m_lngPulseCount = m_lngOldPulseCount = message.getLong();
        m_objLogger.Info("Gateway:  Type=V_DIMMER  Value=%d"CR, message.getLong());
        m_blnPcReceived = true;
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
    if(m_intCounterForceSendBattery == 0)
    {
        m_intCounterForceSendBattery = COUNTER_FORCE_SEND_BATTERY;

        int intBatteryLevel = (readVcc() - 2000)  / 10;   
                
        if (intBatteryLevel > 100)
            intBatteryLevel = 100;
        if (intBatteryLevel < 0)
            intBatteryLevel = 0;

        m_objLogger.Info("Battery: %d"CR, intBatteryLevel);
        gw.sendBatteryLevel(intBatteryLevel);    
    }
    m_intCounterForceSendBattery--;
}


/****************************************************************************/
/* Measure Battery Level on the VCC pin                                     */
/****************************************************************************/
long readVcc() 
{
    long rest;
    // Read 1.1V reference against AVcc
    ADMUX = _BV(REFS0) | _BV(MUX3) | _BV(MUX2) | _BV(MUX1);
    delay(2); // Wait for Vref to settle
    noInterrupts ();
    // start the conversion
    ADCSRA |= _BV (ADSC) | _BV (ADIE);
    set_sleep_mode (SLEEP_MODE_ADC);    // sleep during sample
    interrupts ();
    sleep_mode (); 
    // reading shod be done, but better make sure
    // maybe the timer interrupt fired 
    while (bit_is_set(ADCSRA,ADSC));
    rest = ADCL;
    rest |= ADCH<<8;
    rest = 1126400L / rest; // Back-calcate AVcc in mV
    return rest;
}

/****************************************************************************/
/* Get Temperature and if different from previous one send to gateway       */
/****************************************************************************/
void updateTemperature() 
{
    #ifdef DHT_SENSOR_DIGITAL_INPUT
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
                    (m_intCounterForceSendTemperature == 0 )
               )
            {
                m_intCounterForceSendTemperature = COUNTER_FORCE_SEND_TEMPERATURE;
                m_fltLastTemperature = fltTemperature;
                gw.send(msgTemp.set(fltTemperature, 1));
            }
            else
            {
                m_intCounterForceSendTemperature--;
            }
    
        }
    #endif
}


/****************************************************************************/
/* Get Humidity and if different from previous one send to gateway       */
/****************************************************************************/
void updateHumidity() 
{
    #ifdef DHT_SENSOR_DIGITAL_INPUT
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
                    (m_intCounterForceSendHumidity == 0)
               )
            {
                m_intCounterForceSendHumidity = COUNTER_FORCE_SEND_HUMIDITY;
                
                m_fltLastHumidity = fltHumidity;
                gw.send(msgHum.set(fltHumidity, 1));
            }
            else
            {    
                m_intCounterForceSendHumidity--;
            }
        }
    #endif
}


/****************************************************************************/
/* Get PIR and if different from previous one send to gateway               */
/****************************************************************************/
void updatePIR() 
{
    #ifdef PIR_SENSOR_DIGITAL_INPUT
        boolean blnPIRTripped = digitalRead(PIR_SENSOR_DIGITAL_INPUT) == HIGH; 
        if (blnPIRTripped != m_blnLastPIRTripped) 
        {
            m_blnLastPIRTripped = blnPIRTripped;
            gw.send(msgPir.set(blnPIRTripped?"1":"0"));
            m_objLogger.Info("PIR: %s"CR, (blnPIRTripped?"Motion Detected":"Ok") );        
        }
    #endif
}


/****************************************************************************/
/* Update Led Strip                                                         */
/****************************************************************************/
void setLedStripValue(int a_NewValue)
{
    #ifdef IR_SENSOR_DIGITAL_OUTPUT
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

        //Sleep to avoid getting interferences PIR-IR
        #ifdef PIR_DISABLED_MS    
            mySensorSleep(PIR_DISABLED_MS);
        #endif
    #endif
}

/****************************************************************************/
/* Update Led Strip                                                         */
/****************************************************************************/
void mySensorSleep(unsigned long a_ulMilliseconds)
{
    unsigned long ulMilliseconds = millis() + a_ulMilliseconds;
    while(millis()<ulMilliseconds)
    {
        gw.process();
    }
}


/****************************************************************************/
/* Watt pulse interrupt                                                     */
/****************************************************************************/
void onWattPulse()     
{ 
    //m_objLogger.Debug("onWattPulse"CR);
    unsigned long lngNewBlink = micros();  
    unsigned long lngInterval = lngNewBlink-m_lngLastBlink;
    if (lngInterval<10000L) 
    { 
        // Sometimes we get interrupt on RISING
        return;
    }
    m_lngWatt = (3600000000.0 /lngInterval) / m_dblPpwh;
    m_lngLastBlink = lngNewBlink;

    m_lngPulseCount++;
}

/****************************************************************************/
/* Process Watt pulses                                                      */
/****************************************************************************/
void processWattPulses()     
{ 
    unsigned long lngNow = millis();
    // Only send values at a maximum frequency or woken up from sleep
    bool blnSendTime = lngNow - m_lngLastSend > SEND_FREQUENCY;
    if (m_blnPcReceived && (blnSendTime)) 
    {
        // New watt value has been calculated  
        if (m_lngWatt != m_lngOldWatt) 
        {
            // Check that we dont get unresonable large watt value. 
            // could hapen when long wraps or false interrupt triggered
            if (m_lngWatt<((unsigned long)MAX_WATT)) 
            {
                gw.send(msgWatt.set(m_lngWatt));  // Send watt value to gw 
            }  
            m_objLogger.Info("Watt  Value=%d"CR, m_lngWatt);
            m_lngOldWatt = m_lngWatt;
        }
  
        // Pulse cout has changed
        if (m_lngPulseCount != m_lngOldPulseCount) 
        {
            gw.send(msgPulseCount.set(m_lngPulseCount));  // Send pulse count value to gw 
            double dblKwh = ((double)m_lngPulseCount/((double)PULSE_FACTOR));     
            m_lngOldPulseCount = m_lngPulseCount;
            if (dblKwh != m_dblOldKwh) 
            {
                gw.send(msgKWH.set(dblKwh, 4));  // Send kwh value to gw 
                m_dblOldKwh = dblKwh;
            }
        }    
        m_lngLastSend = lngNow;
    } 
    else if (blnSendTime && !m_blnPcReceived) 
    {
        // No count received. Try requesting it again
        gw.request(CHILD_ID_WATT, V_VAR1);
        m_lngLastSend = lngNow;
    }
  
}

