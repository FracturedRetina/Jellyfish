int cvsW = 500;
int cvsH = 500;
Jellyfish jf;

void setup() {
  boolean fullscreen = false;
  
  if (fullscreen) {
    size(displayWidth, displayHeight);
    cvsW = displayWidth;
    cvsH = displayHeight;
  } else {
    size(cvsW, cvsH);
  }

  jf = new Jellyfish();  

  stroke(255);
  noLoop();
  
  loop();
}

void draw() { 
  background(0);
  stroke(255);
  
  jf.update();
  jf.draw();
}

class Jellyfish {
  float x;
  float y;
  float angle;
  float bellWidth;
  float bellHeight;
  float theta; //Bell width modifier
  boolean thetaMode; //Whether bell is expanding or contracting
  float speed;
  
  Jellyfish() {
    x = cvsW / 2;
    y = cvsH / 2;
    angle = random(360);
    bellWidth = 100;
    bellHeight = 32;
    theta = 0;
    speed = 1;
    thetaMode = true;
    
    for (int i = 0; i < 48; i++) {
      update();
    }
    
    x = cvsW / 2;
    y = cvsH / 2;
    angle = random(360);
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
    
    float pathCurve = 0.5;
    
    
    if (random(1) > 0.5) {
      angle -= random(pathCurve);
    } else {
      angle += random(pathCurve);
    }
    
    x += cos(angle * (PI / 180)) * speed;
    y += sin(angle * (PI / 180)) * speed;
    
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
    arc(0, 0, (bellWidth - 0 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI, CHORD);
    arc(0, 0, (bellWidth - 1 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI);
    arc(0, 0, (bellWidth - 2 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI);
    arc(0, 0, (bellWidth - 3 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI);
    arc(0, 0, (bellWidth - 4 * ((bellWidth + theta) / 5)) + theta, bellHeight * 2, 0, PI);
    line(0, 0, 0, bellHeight);
  }
}
