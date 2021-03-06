int cvsW = 500;
int cvsH = 500;
Jellyfish jf;

void setup() {
  size(cvsW, cvsH);
  
  jf = new Jellyfish();  
  
  stroke(255);
  noLoop();
  
  loop();
}

void draw() { 
  //Set background color to black
  background(0);
  //Set stroke color to white
  stroke(255);
  
  jf.update();
  jf.drawAll();
}

class Jellyfish {
  //X coordinate of the top middle of the jelly's bell
  float x;
  //Y coordinate of the top middle of the jelly's bell
  float y;
  //Direction that the jelly is going (in degrees)
  float angle;
  float bellWidth;
  float bellHeight;
  //Bell width modifier
  float theta;
  //Whether bell is expanding or contracting
  boolean thetaMode;
  float speed;
  
  Jellyfish() {
    //Position jelly in the middle of the canvas
    x = cvsW / 2;
    y = cvsH / 2;
    //Point the jelly in a random angle
    angle = random(360);
    bellWidth = 100;
    bellHeight = 32;
    theta = 0;
    speed = 1;
    thetaMode = true;
  }
  
  void update() {
    if (theta >= 17) {
      thetaMode = false;
      //Minimum speed
      speed = 0.15741837;
    } else if (theta <= -17) {
      thetaMode = true;
    }
    
    if (thetaMode == true) {
      theta += 0.3;
    } else {
      theta -= 0.7;
    }
    
    //Caculate speed
    if (thetaMode == true) {
      speed -= 0.0306125;
    } else {
      speed += 0.0725;
    }
    if (speed < 0) {
      speed = 0;
    }
    
    //Move jelly in the direction that it is facing
    x += cos(angle * (PI / 180)) * speed;
    y += sin(angle * (PI / 180)) * speed;
    
    //If jelly exits the canvas, then wrap it around to the other side
    if (x < 0) {
      x = cvsW;
    }
    if (y < 0) {
      y = cvsH;
    }
    if (x > cvsW) {
      x = 0;
    }
    if (y > cvsH) {
      y = 0;
    }
  }
  
  void draw() {
    translate(x, y);
    rotate(radians(angle + 270));
    noFill();
    //Draw bell lines
    line(-(bellWidth / 2 + theta / 2), 0, bellWidth / 2 + theta / 2, 0);
    arc(0, 0, (bellWidth - 0 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI);
    arc(0, 0, (bellWidth - 1 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI);
    arc(0, 0, (bellWidth - 2 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI);
    arc(0, 0, (bellWidth - 3 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI);
    arc(0, 0, (bellWidth - 4 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI);
    line(0, 0, 0, bellHeight);
    rotate(-radians(angle + 270));
    translate(-x, -y);
  }
  
  void drawAll() {
    this.draw();
    translate(0, -cvsH); //Top
    this.draw();
    translate(0, cvsH * 2); //Bottom
    this.draw();
    translate(-cvsW, -cvsH); //Left
    this.draw();
    translate(2 * cvsW, 0); //Right
  }
}
