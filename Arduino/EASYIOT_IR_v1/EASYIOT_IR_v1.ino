#include <IRLib.h>

//Create a receiver object to listen on pin 11
IRrecv My_Receiver(11);

//Create a decoder object
IRdecode My_Decoder;
IRsend   My_Sender;

void setup()
{
  Serial.begin(9600);
  Serial.println("EnableIRIn");
  My_Receiver.enableIRIn(); // Start the receiver
}

void loop() {
//Continuously look for results. When you have them pass them to the decoder

  /*
  if (My_Receiver.GetResults(&My_Decoder)) {
    My_Decoder.decode();		//Decode the data
    My_Decoder.DumpResults();	//Show the results on serial monitor
    My_Receiver.resume(); 		//Restart the receiver
  }*/

  if (Serial.read() == '1') 
  {
        for(int i=0; i<5;i++)
        {
          Serial.println("Sending Power On ");
          My_Sender.send(NEC,0xF7C03F, 32);
          //My_Sender.send(NECX,0xE040BF, 32);
          delay(100);
        }
  }  
  if (Serial.read() == '2') 
  {
        for(int i=0; i<5;i++)
        {
          Serial.println("Sending Power Off ");
          My_Sender.send(NEC,0xF740BF, 32);
          delay(100);
        }
  }  
}

