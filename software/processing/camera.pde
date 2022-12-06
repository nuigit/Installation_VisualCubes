
void cameraMovementValues(){
  
  if(animation){                                              //the animation needs a different cameraRadius
    angleClock += stepsAngleClock;
    radiusCamera = 1000;
  } else {                                                    // in the other modes
    angleClock += stepsAngleClock;
    radiusCamera = 1000-((sclCubeact-4)*20);                  //when the  sclCubeact changes the camera zoom in -> "camera wiggle"
      if (sclCubeact>sclCube) {                               
         angleClock -= (sclCubeact*stepsAngleClock);          //and when the sclCubeact changes to a bigger value than sclCube the camera angle gets a backspin (so everytime you hit the sensor, the whole grid gets a little backspin and the camera zooms in)
     }
  }
  
  float angle = radians(angleClock);                          
  float xCenter = length1/2;
  float yCenter = length1/2;
  
  if(center){
   zCoordCam = 400;                                           //zCoordCam changes in the modus in which center is enabled, also zCoordEye (the zCoord of the cameratarget)
   zCoordEye = 0;
  } else {
   zCoordCam =200;                                            //default zCoordCam and zCoordEye
   zCoordEye =300;
  }
  
  xCoordCam = xCenter +sin(angle) * radiusCamera;             //calculate the yCoord and the xCoord of the camera (safed in the global variable) 
  yCoordCam = yCenter+ cos(angle) * radiusCamera;
  
} 

void updateSclCubeforCameraBackspin(){                        //overwrite sclCube for the comparison of the old (sclCube) and the new (sclCubeact) gyroValueTemp
    if (sclCubeact != sclCube) {
    sclCube = sclCubeact;
  }
}
