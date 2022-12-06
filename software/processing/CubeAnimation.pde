class CubeAnimation{
  private int length1;
  int sclspeed;
  public int corner;
  int xyznew, xyz1new, xyz2new = 0;
  int t = 0;
  int dir= 1;
  public CubeAnimation(int length1, int sclspeed, int corner) {
    this.length1 = length1;
    this.sclspeed = sclspeed;
    this.corner = corner;
   
  }

  public int getLength() {
    return this.length1;
  }
  void constructCube() {
    t +=1; //timer


    stroke(strokeColorGlob);
    strokeWeight(strokeWeightGlob);
    int time = length1/sclspeed;                                                  //perfect timing for the growing lines, time is long enough so the lines can grow to the max size
    if (t < time) {                                                               //draw first 3 lines
      xyznew += sclspeed;                                                         //growingsteps
      xyznew = constrain(xyznew, 0, length1);                                     //maxlength is length1

      beginShape(LINES);
      vertex(corner, corner, corner);                                             //corner is the O position of the cube, from with corner the cube grows
      vertex(xyznew+corner, corner, corner);

      vertex(corner, corner, corner);
      vertex(corner, xyznew+corner, corner);

      vertex(corner, corner, corner);
      vertex(corner, corner, xyznew+corner);
      endShape();
    } else if (t < time*2) {
      xyz1new += sclspeed;
      xyz1new = constrain(xyz1new, 0, length1);

      beginShape(LINES);                                                          //draw the 3 lines from the last step
      vertex(corner, corner, corner);
      vertex(corner, corner, length1+corner);

      vertex(corner, corner, corner);
      vertex(corner, length1+corner, corner);

      vertex(corner, corner, corner);
      vertex(length1+corner, corner, corner);
      endShape();

      beginShape(LINES);                                                          //draw 6 new growing lines

      vertex(corner, length1+corner, corner);
      vertex(xyz1new+corner, length1+corner, corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, xyz1new+corner, corner);

      vertex(corner, corner, length1+corner);
      vertex(xyz1new+corner, corner, length1+corner);

      vertex(corner, corner, length1+corner);
      vertex(corner, xyz1new+corner, length1+corner);

      vertex(corner, length1+corner, corner);
      vertex(corner, length1+corner, xyz1new+corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, corner, xyz1new+corner);

      endShape();
    } else if (t < time*3) {
      xyz2new += sclspeed;
      xyz2new = constrain(xyz2new, 0, length1);


      beginShape(LINES);                                                          //draw the 9 lines from the last steps (which are "full grown")
      vertex(corner, corner, corner);
      vertex(corner, corner, length1+corner);

      vertex(corner, corner, corner);
      vertex(corner, length1+corner, corner);

      vertex(corner, corner, corner);
      vertex(length1+corner, corner, corner);

      vertex(corner, length1+corner, corner);
      vertex(length1+corner, length1+corner, corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, length1+corner, corner);

      vertex(corner, corner, length1+corner);
      vertex(length1+corner, corner, length1+corner);

      vertex(corner, corner, length1+corner);
      vertex(corner, length1+corner, length1+corner);

      vertex(corner, length1+corner, corner);
      vertex(corner, length1+corner, length1+corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, corner, length1+corner);

      endShape();

      beginShape(LINES);                                                          //draw 3 new growing lines (last one)

      vertex(corner, length1+corner, length1+corner);
      vertex(xyz2new+corner, length1+corner, length1+corner);

      vertex(length1+corner, corner, length1+corner);
      vertex(length1+corner, xyz2new+corner, length1+corner);

      vertex(length1+corner, length1+corner, corner);
      vertex(length1+corner, length1+corner, xyz2new+corner);
      endShape();
    } else if (t < time*4) {                                                      // instead drawing all full grown vertex to an cube for t<time*4
      noFill();
      pushMatrix();
      translate(length1/2+corner, length1/2+corner, length1/2+corner);
      box(length1);                                                               //draw a box
      popMatrix();
    } else if (t < time*5) {                                                      //the same process of constructing the cube is used to destruct it
      xyz2new -= sclspeed;
      xyz2new = constrain(xyz2new, 0, length1);

      beginShape(LINES);
      vertex(corner, corner, corner);
      vertex(corner, corner, length1+corner);

      vertex(corner, corner, corner);
      vertex(corner, length1+corner, corner);

      vertex(corner, corner, corner);
      vertex(length1+corner, corner, corner);

      vertex(corner, length1+corner, corner);
      vertex(length1+corner, length1+corner, corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, length1+corner, corner);

      vertex(corner, corner, length1+corner);
      vertex(length1+corner, corner, length1+corner);

      vertex(corner, corner, length1+corner);
      vertex(corner, length1+corner, length1+corner);

      vertex(corner, length1+corner, corner);
      vertex(corner, length1+corner, length1+corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, corner, length1+corner);

      endShape();

      beginShape(LINES);

      vertex(corner, length1+corner, length1+corner);
      vertex(xyz2new+corner, length1+corner, length1+corner);

      vertex(length1+corner, corner, length1+corner);
      vertex(length1+corner, xyz2new+corner, length1+corner);

      vertex(length1+corner, length1+corner, corner);
      vertex(length1+corner, length1+corner, xyz2new+corner);
      endShape();
    } else if (t < time*6) {
      xyz1new -= sclspeed;
      xyz1new = constrain(xyz1new, 0, length1);

      beginShape(LINES);
      vertex(corner, corner, corner);
      vertex(corner, corner, length1+corner);

      vertex(corner, corner, corner);
      vertex(corner, length1+corner, corner);

      vertex(corner, corner, corner);
      vertex(length1+corner, corner, corner);
      endShape();


      beginShape(LINES);

      vertex(corner, length1+corner, corner);
      vertex(xyz1new+corner, length1+corner, corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, xyz1new+corner, corner);

      vertex(corner, corner, length1+corner);
      vertex(xyz1new+corner, corner, length1+corner);

      vertex(corner, corner, length1+corner);
      vertex(corner, xyz1new+corner, length1+corner);

      vertex(corner, length1+corner, corner);
      vertex(corner, length1+corner, xyz1new+corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, corner, xyz1new+corner);

      endShape();
    } else if (t < time*7) {
      xyznew -= sclspeed;
      xyznew = constrain(xyznew, 0, length1);

      beginShape(LINES);
      vertex(corner, corner, corner);
      vertex(xyznew+corner, corner, corner);

      vertex(corner, corner, corner);
      vertex(corner, xyznew+corner, corner);

      vertex(corner, corner, corner);
      vertex(corner, corner, xyznew+corner);
      endShape();
    } else if (t < time*8) {
    } else if (t < time*9) {
      t = 0;
    }
  }

  void constructMovingCube() {                                                       //this is a modified constructCube() in which the cube moves diagonal to the top a corner
    corner += dir;                                                                   //the "clock" for the moving cube, so it cant get further than the corner
    if ( corner >= length1) {
      dir *= -1;
    } else if (corner <= 0) {
      dir *= -1;
    }
    t +=1;
    stroke(strokeColorGlob);
    strokeWeight(strokeWeightGlob);
    int time = length1/sclspeed;
    if (t < time) {                                                                 //same as the normal constructCube()
      xyznew += sclspeed;
      xyznew = constrain(xyznew, 0, length1);

      beginShape(LINES);
      vertex(corner, corner, corner);
      vertex(xyznew+corner, corner, corner);

      vertex(corner, corner, corner);
      vertex(corner, xyznew+corner, corner);

      vertex(corner, corner, corner);
      vertex(corner, corner, xyznew+corner);
      endShape();
    } else if (t < time*2) {
      xyz1new += sclspeed;
      xyz1new = constrain(xyz1new, 0, length1);

      beginShape(LINES);
      vertex(corner, corner, corner);
      vertex(corner, corner, length1+corner);

      vertex(corner, corner, corner);
      vertex(corner, length1+corner, corner);

      vertex(corner, corner, corner);
      vertex(length1+corner, corner, corner);
      endShape();

      beginShape(LINES);

      vertex(corner, length1+corner, corner);
      vertex(xyz1new+corner, length1+corner, corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, xyz1new+corner, corner);

      vertex(corner, corner, length1+corner);
      vertex(xyz1new+corner, corner, length1+corner);

      vertex(corner, corner, length1+corner);
      vertex(corner, xyz1new+corner, length1+corner);

      vertex(corner, length1+corner, corner);
      vertex(corner, length1+corner, xyz1new+corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, corner, xyz1new+corner);

      endShape();
    } else if (t < time*3) {
      xyz2new += sclspeed;
      xyz2new = constrain(xyz2new, 0, length1);


      beginShape(LINES);
      vertex(corner, corner, corner);
      vertex(corner, corner, length1+corner);

      vertex(corner, corner, corner);
      vertex(corner, length1+corner, corner);

      vertex(corner, corner, corner);
      vertex(length1+corner, corner, corner);

      vertex(corner, length1+corner, corner);
      vertex(length1+corner, length1+corner, corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, length1+corner, corner);

      vertex(corner, corner, length1+corner);
      vertex(length1+corner, corner, length1+corner);

      vertex(corner, corner, length1+corner);
      vertex(corner, length1+corner, length1+corner);

      vertex(corner, length1+corner, corner);
      vertex(corner, length1+corner, length1+corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, corner, length1+corner);

      endShape();

      beginShape(LINES);

      vertex(corner, length1+corner, length1+corner);
      vertex(xyz2new+corner, length1+corner, length1+corner);

      vertex(length1+corner, corner, length1+corner);
      vertex(length1+corner, xyz2new+corner, length1+corner);

      vertex(length1+corner, length1+corner, corner);
      vertex(length1+corner, length1+corner, xyz2new+corner);
      endShape();
    } else if (t < time*4) {
      noFill();
      pushMatrix();
      translate(length1/2+corner, length1/2+corner, length1/2+corner);
      box(length1);
      popMatrix();
    } else if (t < time*5) {
      xyz2new -= sclspeed;
      xyz2new = constrain(xyz2new, 0, length1);


      beginShape(LINES);
      vertex(corner, corner, corner);
      vertex(corner, corner, length1+corner);

      vertex(corner, corner, corner);
      vertex(corner, length1+corner, corner);

      vertex(corner, corner, corner);
      vertex(length1+corner, corner, corner);

      vertex(corner, length1+corner, corner);
      vertex(length1+corner, length1+corner, corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, length1+corner, corner);

      vertex(corner, corner, length1+corner);
      vertex(length1+corner, corner, length1+corner);

      vertex(corner, corner, length1+corner);
      vertex(corner, length1+corner, length1+corner);

      vertex(corner, length1+corner, corner);
      vertex(corner, length1+corner, length1+corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, corner, length1+corner);

      endShape();

      beginShape(LINES);

      vertex(corner, length1+corner, length1+corner);
      vertex(xyz2new+corner, length1+corner, length1+corner);

      vertex(length1+corner, corner, length1+corner);
      vertex(length1+corner, xyz2new+corner, length1+corner);

      vertex(length1+corner, length1+corner, corner);
      vertex(length1+corner, length1+corner, xyz2new+corner);
      endShape();
    } else if (t < time*6) {
      xyz1new -= sclspeed;
      xyz1new = constrain(xyz1new, 0, length1);

      beginShape(LINES);
      vertex(corner, corner, corner);
      vertex(corner, corner, length1+corner);

      vertex(corner, corner, corner);
      vertex(corner, length1+corner, corner);

      vertex(corner, corner, corner);
      vertex(length1+corner, corner, corner);
      endShape();


      beginShape(LINES);

      vertex(corner, length1+corner, corner);
      vertex(xyz1new+corner, length1+corner, corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, xyz1new+corner, corner);

      vertex(corner, corner, length1+corner);
      vertex(xyz1new+corner, corner, length1+corner);

      vertex(corner, corner, length1+corner);
      vertex(corner, xyz1new+corner, length1+corner);

      vertex(corner, length1+corner, corner);
      vertex(corner, length1+corner, xyz1new+corner);

      vertex(length1+corner, corner, corner);
      vertex(length1+corner, corner, xyz1new+corner);

      endShape();
    } else if (t < time*7) {
      xyznew -= sclspeed;
      xyznew = constrain(xyznew, 0, length1);

      beginShape(LINES);
      vertex(corner, corner, corner);
      vertex(xyznew+corner, corner, corner);

      vertex(corner, corner, corner);
      vertex(corner, xyznew+corner, corner);

      vertex(corner, corner, corner);
      vertex(corner, corner, xyznew+corner);
      endShape();
    } else if (t < time*8) {
    } else if (t < time*9) {
      t = 0;
    }
  }
}

void musicUnites(){                                                               //the musicUnites text
   textSize(100);
    textAlign(LEFT);
    fill(255);
    pushMatrix();
    translate(0, -3);
    text("music", 300, 300);
    text("unites", 300, 400);
    text("us.", 300, 500);
    popMatrix();
  }
