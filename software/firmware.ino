#include <Wire.h>
#include <MPU6050.h>  // Accelerometer
#include <Keypad.h>   // KeyPad
#include <Encoder.h>  // Encoder
#include <elapsedMillis.h> //Timer

MPU6050 mpu;
int accelValue = 4;
int accMax = 10000;
const byte ROWS = 4; //four rows
const byte COLS = 4; //four columns
char hexaKeys[ROWS][COLS] = {
  {'1', '2', '3', '+'},
  {'4', '5', '6', '-'},
  {'7', '8', '9', 'c'},
  {'*', '0', '#', 'd'}
};
//byte rowPins[ROWS] = {9, 8, 7, 6}; //connect to the row pinouts of the keypad teensy
byte rowPins[ROWS] = {13,12,14,27}; //connect to the row pinouts of the keypad esp32
//byte colPins[COLS] = {5, 4, 3, 2}; //connect to the column pinouts of the keypad teensy
byte colPins[COLS] = {26, 25, 33, 32};//connect to the column pinouts of the keypad esp32
Keypad customKeypad = Keypad( makeKeymap(hexaKeys), rowPins, colPins, ROWS, COLS); //initialize an instance of class NewKeypad

//const int CLK = 14; // Definition der Pins. CLK an D6, DT an D5 für Teensy
const int CLK = 4 // Definition der Pins. CLK an D6, DT an D5 für ESP32
const int DT = 15;
//const int SW = 16; // Der Switch wird mit Pin D2 Verbunden. ACHTUNG : Verwenden Sie einen interrupt-Pin! Teensy
const int SW = 2; // Der Switch wird mit Pin D2 Verbunden. ACHTUNG : Verwenden Sie einen interrupt-Pin! ESP32
long encValue = 10; // Definition der "alten" Position (Diese fiktive alte Position wird benötigt, damit die aktuelle Position später im seriellen Monitor nur dann angezeigt wird, wenn wir den Rotary Head bewegen)
Encoder myEnc(DT, CLK); // An dieser Stelle wird ein neues Encoder Projekt erstellt. Dabei wird die Verbindung über die zuvor definierten Varibalen (DT und CLK) hergestellt.

elapsedMillis printTimer;
elapsedMillis accTimer;

int mode = 0; // 0=cubeMode 1=colorMode
char keyPressed = '0';


////////////////////////////////////////////////////////////////////////////////// SETUP
void setup() {
  Serial.begin(115200); // begin serial
  delay(100); // wait till serial connected

  // start accelerometer
  while(!mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G)) { delay(500); }   

  encValue = 10;
  myEnc.write(encValue*4);
}
//////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////// LOOP
void loop() {
  /* get accelerometer values */
  Vector rawAccel = mpu.readRawAccel();
  float z = abs(rawAccel.ZAxis-17500); //get acc values Z axis (-17500) because of the drops (positiv and negative Amplitude);
  int ac = floor(map(z, 0, accMax,4 , 14)); //mapping values to gridsize min and max (4,14);
  ac = constrain(ac, 4, 14); // constrain ac;
 
  if(ac>accelValue){accelValue=ac;} //if ac bigger than accelValue (4), take the ac value and save it to accelValue;
  if(accTimer>50){ //accTimer, every 50millis;
    accTimer = 0; //set timer to 0;
    if(accelValue>4){ accelValue--;} // accelValue -1 until accelValue =4; -> every 50 millis the value of accelValue -1 -> effect of grid getting slowly smaller after "hit"
  }
  
  /* get keypad values */
  char k = customKeypad.getKey();
  if(k){ keyPressed = k;}
  
//  if(keyPressed == NULL){ keyPressed = '0'; }
//  else{
    switch(keyPressed){
      case '+': accMax+=100; keyPressed='0'; break; //keyPressed "0" because otherwise the +/- will get printed to the serial port, so you say keyPressed is 0 and 0 gets printed.
      case '-': accMax-=100; keyPressed='0'; break;
      case 'c': keyPressed='0'; break;
      case 'd': keyPressed='0'; break;
      case '*': keyPressed='0'; mode=0; break;
      case '#': keyPressed='0'; mode=1; break;
    }
  // }

  /* get encoder values */
  int e = myEnc.read();           
  e = constrain(e, 0, 400);   //because of encoder the real value is not 0-400, its 0-100;
  myEnc.write(e);
  encValue = e/4; //encoder has 4 clicks every spinclick so you have to devide through 4;

  /* print every 10ms */
  if(printTimer>10){
    printTimer = 0;
    Serial.print(keyPressed); Serial.print(',');  //print keypadValue
    Serial.print(encValue); Serial.print(',');   //print encoderValue
    Serial.print(accelValue); Serial.print(','); //accelValue, value from MPU6050 (gyro);
    Serial.print(mode); Serial.print(','); //accelValue, value from MPU6050 (gyro);
    Serial.print('\n'); //end
  } 
}
//////////////////////////////////////////////////////////////////////////////////
