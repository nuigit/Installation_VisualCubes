class Cube {
  PVector cubePos = new PVector(0,0,0);
  PVector cubeSize = new PVector(0,0,0);
  color fillColor = color(0,0,0,0);
  color strokeColor = color(255,255,255,255);
  float strokeWgt = strokeWeightGlob;

  void setCubeColor(int cn, float h){                        //set color
    int c=0;
    c=floor(h/100); 
    c=min(c,4);
    fillColor = colorSet[cn][c];
  }
  
  void drawCube(){                                           //draw cube
    pushStyle();
    pushMatrix();
    
    /* set style */
    if(alpha(fillColor)>0){ fill(fillColor); }               //because first colortheme is 0,0,0,... the first colortheme has noFill (look at the colorSet[0] Array)
    else{ noFill(); }
    
    if(alpha(strokeColor)==0){ noStroke(); }                 // <-maybe for future project 
    else{ stroke(strokeColor); strokeWeight(strokeWgt); }    //set strokecolor and strokeWeight
    
    /*draw cube*/   
    translate(cubePos.x, cubePos.y, cubePos.z); 
    box(cubeSize.x, cubeSize.y, cubeSize.z);
    
    popMatrix();
    popStyle();
  }
}
