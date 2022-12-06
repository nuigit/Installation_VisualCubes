import peasy.*;  //for peasycam (testing purposes)
PeasyCam cam;

//teensyValues
String receivedValues;                   //all receivedValues from the serial to the teensy
int keypadValue;                         //first position keypadValue (pressed key)
float encoderValue;                      //encoderValue for hightMulti(change the sensitivity for the visuals from the input)
int gyroValueTemp;                       //gyrosensor Values (mpu6050) which grow the gridsize
int modusSwitch;                         // 0 or 1 which change the modus (on keypad * for modus= 0 and # for modus = 1) 0=colortheme, 1=cubeappearance
float hightMulti = 10;                   // multiplier to manually change height 

//globalCubeValues
int sclCubeact;                          //latest teensy gyroValueTemp
int sclCube;                             //"historical" value of sclCubeact
int length1 = 600;                       //size of the grid (l,w)

// float [][]fftValueArray; for history (fft values safed in array)

//timerFrameSaver
long frameTimer;                         //timer millis()
int frameSaveTimeOut = 900000;           //time 15min (after which a frame gets saved)

//cameraAngleClock
float angleClock = 0;                    //cameraAngle (0 to 360);
float stepsAngleClock = 0.5;             //steps in which the camera moves
//camera
int radiusCamera;                        
float xCoordCam;                         
float yCoordCam;
float zCoordCam;
float zCoordEye;    

//globalPropertiesStroke
float strokeWeightGlob = 3.0;
color strokeColorGlob = color(255,255,255,255);

//animation
CubeAnimation cube1animation;
CubeAnimation cube2animation;
int speedCube = 5;                        //speed of the growing lines in the animation
