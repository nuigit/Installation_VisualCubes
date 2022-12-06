import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioInput in;
//AudioOutput out;
FFT fftLog;
//BeatDetect beat;

void setupAudio(){
  minim = new Minim(this);
  //beat = new BeatDetect();
  in = minim.getLineIn(Minim.STEREO, 1024);
  //out = minim.getLineOut(Minim.STEREO, 1024);
  fftLog = new FFT( in.bufferSize(), in.sampleRate() );
  //fftLog = new FFT( out.bufferSize(), out.sampleRate() );                     //<- maybe future project with output
  fftLog.logAverages( 100, 29);
}

void loopFFT(){
  // fftValueArray = new float[sclCubeact][sclCubeact];                         //array for fft values depending on the scale (sclCubeact)
  
  int n = bandWidthOfLogAverages();                                             //math to calculate how many bands in each "hz width"
  fftLog.logAverages( 100, n );                                                 //generate the logAverages proportional to the scale
  fftLog.forward( in.mix );
  //fftLog.forward( out.mix );
}


int bandWidthOfLogAverages(){                                                   //function to calculate how many bands depending on the scale (sclCubeact)
  float floatscl = sclCubeact;
  float math = (floatscl*floatscl / 8);
  int bandWidthLogAvg =( ceil(math)+2);
  return bandWidthLogAvg;                                                       //return bands
}


float fftToZValue(int segment){                                                 //from fftValues to zValue (height of the cubes in modus 1)
   float z = 0.0;
   if (segment<fftLog.avgSize()) {                                              //only if the i (segment) is smaller than the total avgSize it gets mapped and constrained
    z = map(fftLog.getAvg(segment), 0, 400, 0, length1 ) * hightMulti;          //hightMulti is the encoderValue -> because depending on the input volume you have to adjust the fft values otherwise they are to small
    z = constrain(z, 0, length1);                                               //if the constrain is disabled you have in modus 1 an "openEnd" of heightValues
    // fftValueArray[y][x] = z; // for history
  }
  return(z);
 }
