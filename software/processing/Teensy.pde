import processing.serial.*;
Serial Teensy;

void setupTeensy(){                                                  //get teensyValues in setup
  String portName = "COM4";
  Teensy = new Serial(this, portName, 115200);  
  askTeensyValuesDraw();                                             
  sclCube = gyroValueTemp;                                           //set sclCube for "historical" sclCubeact !!only in setup
}

void askTeensyValuesDraw(){                                          //get teensyValues in draw
  if(Teensy.available() > 0) {
      receivedValues = Teensy.readStringUntil('\n');
      //print(receivedValues);                                       //print for testing purposes
      Teensy.clear();
      
      String[] a = split (receivedValues, ',');                      //split the received string
      keypadValue = Integer.parseInt(a[0].trim());
      encoderValue = 0.2 * Integer.parseInt(a[1].trim());
      gyroValueTemp = Integer.parseInt(a[2].trim());
      modusSwitch = Integer.parseInt(a[3].trim()); 
      hightMulti = encoderValue;
      sclCubeact = gyroValueTemp;
      
      switch(modusSwitch){                                          //execute changeMode or changeColor depending on the modusSwitch 
        case 0: changeMode(keypadValue); break;
        case 1: changeColor(keypadValue); break;
      }
    }
}





 

 
