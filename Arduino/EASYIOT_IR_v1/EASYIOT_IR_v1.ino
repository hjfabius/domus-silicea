#include <IRLib.h>

//Create a receiver object to listen on pin 11
IRrecv My_Receiver(11);

//Create a decoder object
IRdecode My_Decoder;
IRsend   My_Sender;

void setup()
{
  Serial.begin(115200);
  Serial.println("EnableIRIn");
  //My_Receiver.enableIRIn(); // Start the receiver
}

void loop() {
//Continuously look for results. When you have them pass them to the decoder

  /*
  if (My_Receiver.GetResults(&My_Decoder)) {
    My_Decoder.decode();		//Decode the data
    My_Decoder.DumpResults();	//Show the results on serial monitor
    My_Receiver.resume(); 		//Restart the receiver
  }*/
  unsigned long lngStart = millis();

  switch(Serial.read())
  {
      case '1':
            for(int i=0; i<5;i++)
            {
              Serial.println("Sending Power On ");
              My_Sender.send(NEC,0xF7C03F, 32);
              //My_Sender.send(NECX,0xE040BF, 32);
              delay(100);
            }
            Serial.println("-");
          break;
      case '2':
            for(int i=0; i<5;i++)
            {
              Serial.println("Sending Power Off ");
              My_Sender.send(NEC,0xF740BF, 32);
              delay(100);
            }
            Serial.println("-");
          break;
      case '3':
            //for(int i=0; i<16;i++)
            while(millis()<lngStart+(200*16))
            {
                Serial.println("Sending Decrease Light ");
                My_Sender.send(NEC,0xF7807F, 32);   //Led Strip - Decrease Light
                delay(20);
            }
            Serial.println("-");
          break;
      case '4':
            //for(int i=0; i<16;i++)
            while(millis()<lngStart+(200*16))
            {
               Serial.println("Sending Increase Light");
               My_Sender.send(NEC,0xF700FF, 32);   //Led Strip - Increase Light
               delay(20);
            }
            Serial.println("-");
          break;
      case '5':
            //for(int i=0; i<16;i++)
            while(millis()<lngStart+(150*20))
            {
                Serial.println("Sending Decrease Light ");
                My_Sender.send(NEC,0xF7807F, 32);   //Led Strip - Decrease Light
                delay(20);
            }
            Serial.println("-");
          break;
      case '6':
            //for(int i=0; i<16;i++)
            while(millis()<lngStart+(150*20))
            {
               Serial.println("Sending Increase Light");
               My_Sender.send(NEC,0xF700FF, 32);   //Led Strip - Increase Light
               delay(20);
            }
            Serial.println("-");
          break;
      default:
          break;
      
  }

}

