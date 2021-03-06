  
  /*
   
   Created by David Cuartielles
   modified 30 Aug 2011
   By Tom Igoe
   
   modified by steve daniels jan 2013
   
   
   Circuit:
   
   Your sensor must be connected to a voltage divider (ie in series wit ha fixed resistor )
   CONNECT ONE END OF FIXED RESISTER TO 5V
   connect other end to soft sensor
   connect remianing end of soft sensor to ground
   
   connect a jumper from the your sense pin to the junction of fixed resister and soft sensor
   
   This example code is in the public domain.
   
   http://arduino.cc/en/Tutorial/AnalogInput
   
   */
  
  
  #include <Glue.h>
  
  Glue messageToProcessing;          // 
  
  int sensorPin = A2;    // select the input pin for the soft sensor
  int ledPin = 13;
  int sensorValue = 0;  // variable to store the value coming from the sensor
  
  int threshold = 15;  // determine this empirically
  
  void setup() {
  
    Serial.begin(9600);  // we will output our sensor value to serial window
    messageToProcessing.create();
  
    pinMode(13,OUTPUT);
  }
  
  
  void loop() {
  
    // read the value from the sensor:
    sensorValue = analogRead(sensorPin);    
  
    // clear and assemble a message with GLUE
    messageToProcessing.clear();                   // clear the old message
    
    messageToProcessing.add( 100 );          // add the actual dialValue (int)
    messageToProcessing.add(  sensorValue  );
    messageToProcessing.add( 200 );
    messageToProcessing.add( 300 );
    // send the message with SERIAL
    Serial.println( messageToProcessing.getPackage()) ;
  

    if (sensorValue > threshold) {
      digitalWrite(13, HIGH);
    }
    else {
      digitalWrite(13,LOW);
    }
  
    delay(100);                  
  }

