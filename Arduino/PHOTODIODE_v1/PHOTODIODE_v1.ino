/* Here is a bare-bones Arduino sketch to read the
   outputs of the photodiode detectors described
   in Figure 1 and Figure 2. The output pin of the
   circuit's opamp is connected to analog pin 0
   of the Arduino. The data are read every 0.1 second
   in this example. However, you can change the sampling
   rate by simply changing the argument of the
   delay() statement. */
 
 
void setup(void) {
 
  Serial.begin(9600);
  Serial.println();
  pinMode(13, OUTPUT);    
  pinMode(2, INPUT);
}
 
void loop(void) 
{
   

  digitalWrite(13, digitalRead(2));
   
}
