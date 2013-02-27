/*
Code based on “Arduino meets Processing” Potentiometer example
>> http://webzone.k3.mah.se/projects/arduino-workshop/projects/arduino_meets_processing/instructions/poti.html

Reads 4 analog inputs and visualizes them by drawing a 2x2 grid,
using grayscale shading of each square to represent sensor value.
>> http://www.kobakant.at/DIY/?cat=347
*/

import processing.serial.*;

Scissors serialParser;  // you can get a copy of this at github.com.hex705

// definition of window size
// you can change the size of the window as you like
// the thresholdGraph will be scaled to fit
// the optimal size for the thresholdGraph is 1000 x 400
int xWidth = 1200;
int yHeight = 750;

// xPos input array, using prefix
int[] xPosArr= {0,0,0,0,0,0}; 

// stores values in thresholding class

int[] messageArr= {0,0,0,0,0,0}; 
  
// Arrays for threshholding
int[] threshMax= {0,0,0,0,0,0}; 
int[] threshMin= {0,0,0,0,0,0}; 
int[] threshScale = {2,5,1,1,1,1}; 
  
// variables for serial connection. portname and baudrate are user specific
Serial port1;

//Set your serial port here (look at list printed when you run the application once)
String V3 = Serial.list()[8];
String portname1 = V3;
int baudrate = 9600;
  
int prefix = 1;
boolean myCatch = true;
int serialIN = 0;
int serialINPUT = 0; 
String buffer = ""; 
int value = 0; 

// ThresholdGraph draws grid and poti states
ThresholdGraph in;

void setup(){
  // set size and framerate
  size(xWidth, yHeight);
  frameRate(25);
  background(255);
  strokeWeight(5);
  stroke(0);
  smooth();
  strokeCap(ROUND);

  // establish serial port connection  
  println(Serial.list());  // print serial list  
  port1 = new Serial(this, portname1, baudrate);
  
  // attach the serial parser (SCISSORS) to the serial PORT
  serialParser = new Scissors( port1 ); 
 

  // create DisplayItems object
  in = new ThresholdGraph();
  
  // THRESHOLD VALUES:
  // using the thresholdGraph you can determine the MIN and MAX values
  // of your sensors. Enter these here. They must lie between 0 and 1000.
  
    //MIN trashhold
    threshMin[0] = 20;   // one
    threshMin[1] = 20;   // two
    threshMin[2] = 20;   // three
    threshMin[3] = 20;   // four
    threshMin[4] = 20;   // five
    threshMin[5] = 20;   // six
    
    //MAX trashhold
    threshMax[0] = 50;   // one
    threshMax[1] = 600;   // two
    threshMax[2] = 600;   // three
    threshMax[3] = 600;   // four
    threshMax[4] = 600;   // five
    threshMax[5] = 600;   // six
    
      //MIN trashhold
    threshMin[0] = 20;   // one
    threshMin[1] = 20;   // two
    threshMin[2] = 20;   // three
    threshMin[3] = 20;   // four
    threshMin[4] = 20;   // five
    threshMin[5] = 20;   // six
}//end setup


// draw listens to serial port, draw 
void draw(){
  
  
    
     // use SCISSORS to extract the new fill VALUE from ARDUINO
     if ( serialParser.update() > 0 ) {   //  polls SERIAL port and returns number of ELEMENTS in MESSAGE
     
          println("from arduino : " + serialParser.getRaw() );   // for debug purposes
          
          // we are only going to look at one value here
          xPosArr[0] = serialParser.getInt(0); // should get all six values
           xPosArr[1] = serialParser.getInt(1); // should get all six values
            xPosArr[2] = serialParser.getInt(2); // should get all six values
             xPosArr[3] = serialParser.getInt(3); // should get all six values
     }  // end check serial
     
  // threshold serial input  
  threshHolding();  

  // draw serial input
  in.update();
}//end draw()
