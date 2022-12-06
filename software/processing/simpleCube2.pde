/*================================================================*/
//colorthemes saved in array
color colorSet[][] = {
  {color(0), color(0), color(0), color(0), color(0)},
  {color(255,0,123,13), color(147, 27, 168, 15), color(232, 218, 28, 17), color(28, 232, 140, 15), color(28, 215, 232, 18)},
  {color(4,107,122, 10),color(182,221,170, 10),color(255,109,249, 10),color(99,48,122,10),color(114,255,71, 20)},
  {color(236,238,235, 50),color(170,187,205, 60),color(181,26,44, 70),color(124,123,163,70),color(64,50,86, 90)},
  {color(0,8,64, 30),color(46,59,240, 40),color(66,22,210, 40),color(221,50,179,50),color(251,41,253, 70)},
  {color(0,0,0,20),color(120,120,120,30),color(255,255,255,50),color(255,255,255,50),color(200,200,200, 80)},
  {color(255, 10, 51, 20),color(255, 10, 182, 30),color(120, 10, 255,40),color(120, 10, 255,40),color(10, 51, 255,40)},
};

int colorTheme = 0;
int cubeMode = 0;

//booleans for modus
boolean animation = false; //animation
boolean center = false; //the box scale in both directions from the middle, 
//so you have to position the box/cube half the height upwards, when enable center, the cube scales again from the mid in both directions
boolean flat = false; //cubes have the height 1 -> floating "2D" Rects
boolean cubeZPosRan = false; //cubes have random z values (0,length1)
boolean cubeEqualScale = false; //cube scale equal (w,h,l) with fft values

/*================================================================*/
void setup(){
  fullScreen(P3D/*, 3 (<-choose Screen)*/); 
  //size(900, 900, P3D); //for test purposes
  //cam = new PeasyCam(this, 100); //for test purposes
    
  setupTeensy(); //load and set up teensyValues
  setupAudio();  //load and set up minimValues

  cube1animation= new CubeAnimation(length1/2, speedCube, 0 );
  cube2animation= new CubeAnimation(length1, speedCube*2, 0);

}

/*================================================================*/
void draw(){
  /*----------------------------------------------------------------*/
  /*Values for Draw*/
  askTeensyValuesDraw(); //reading teensyValues
  loopFFT(); // get audio and calculate FFT
  cameraMovementValues(); //calculate camera position in dependency of modus (center, animation ..)
  float gridSize = length1/sclCubeact; //set the gridSize with the new teensyValues
  
  /*----------------------------------------------------------------*/
  /*Draw Section*/
  background(0);
  beginCamera();
  camera(xCoordCam, yCoordCam, zCoordCam, length1/2, length1/2, zCoordEye, 0, 0.01, -0.1);  //calculated in cameraMovementValues();
  
  if (animation){
  cube1animation.constructCube(); //animation cube1
  cube2animation.constructCube(); //animation cube2
  pushMatrix();                   //position musicUnites
  rotateX(-PI/2);
  rotateY(PI/2);
  translate(-850, -780, 600);
  musicUnites();
  popMatrix();
  } 
  
  else{
  for(int y=0; y<sclCubeact; y++){
    int i = y*sclCubeact;                //i = sclCubeact*sclCubeact -> every cube has a different height because of the his i
    for(int x=0; x<sclCubeact; x++){
      i++;
      float zValue = fftToZValue(i);
      Cube cube = new Cube();
      cube.setCubeColor(colorTheme, zValue);  //set color
      cube.strokeColor = color(255,255,255,255); //stroke color
      
      /*----cube position with variation for each modus*/
      cube.cubePos.x = x*gridSize; //x pos
      cube.cubePos.y = y*gridSize; //y pos
      
      /*----zpos depend on modus*/
      if(center){             //cube z position = 0  
       cube.cubePos.z = 0; 
      } else if(flat){            //cube z position = zheight -> floating rects 
        cube.cubePos.z = zValue;
      } else if(cubeZPosRan){      //cube z position = random(0,length1) -> because of random z it looks like a big cube of little cubes
        cube.cubePos.z = random(0,length1);
      } else{
      cube.cubePos.z = zValue/2;  //no modus the z position is half of the cubeheight(zValue)
      } 
      
      /*----cube size with variation for each modus*/
      cube.cubeSize.x = gridSize; // width
      cube.cubeSize.y = gridSize; // length
      
      /*----height and other size changes depend on modus*/
      if(flat){                        //floating rects cubeSize z has to be 1 -> looks like 2D rect
      cube.cubeSize.z = 1 ;
      } else if (cubeEqualScale){      //cube random z position (0,length1)
      float sidelength= map ( zValue, 0, 500, 0, length1/sclCubeact); //mapping z value to the cube sidelength (depending on length1/sclCubeact)
      cube.cubeSize.x = sidelength;    //l,h,w grow equal
      cube.cubeSize.y = sidelength;
      cube.cubeSize.z = sidelength;
      } else {
      cube.cubeSize.z = zValue; //no modus the height of the cubes is zValue
      }
      cube.drawCube();
      }
    }
  }
  endCamera();
  updateSclCubeforCameraBackspin();  
  snapShotsAfterTime();                  
}


 void snapShotsAfterTime(){                        //takes screenshot after timer (15min in this case)
   if (millis()>frameTimer+frameSaveTimeOut) {
    frameTimer=millis();
    saveFrame("/bilderWgParty/line-####.jpg");
  }
 }

/*colormodi function*/                             //modusswitch = 0
void changeColor(int keyVal){                      //to use the keypad in two main modus, we send a modusswitch value 
  if(keyVal==colorTheme) return;                   //from the teensy.
  if(keyVal==0) return;                            //so you can use all keypadValues in each mode, here you choose a colorTheme
                                                   //with the keyVal (keypad input)
  colorTheme = keyVal;
  colorTheme = constrain(colorTheme, 0, 6);
}

/*changemodi function*/                            //modusswitch = 1
void changeMode(int keyVal){                       //same concept for the "optical" appearance of the cubes
  if(keyVal==cubeMode) return;
  if(keyVal==0) return;
  
  cubeMode = keyVal;
  switch(cubeMode){                                //all modus in changeMode
    case 1: center=false; flat=false; cubeZPosRan= false; cubeEqualScale=false; animation=true; break; //animation
    case 2: center=false; flat=false; cubeZPosRan= false; cubeEqualScale=false; animation=false;break; // raising bars
    case 3: center=true;  flat=false; cubeZPosRan= false; cubeEqualScale=false; animation=false;break; // centerd bars
    case 4: center=false;  flat=true; cubeZPosRan= false; cubeEqualScale=false; animation=false;break; // flat mode
    case 5: center=false; flat=false; cubeZPosRan = true; cubeEqualScale=true; animation=false;break; // cube mode
    case 6: break;
    case 7: break;
    case 8: break;
    case 9: break;
  }

}
