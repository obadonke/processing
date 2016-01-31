enum WalkMode {
  Simple,
  Monte_Linear,
  Monte_Exponential
}

class Walker {
  float x;
  float y;
  boolean isExponential;
  int walkerColor;
  WalkMode mode;
  
  Walker(WalkMode mode, int col) {
    x = width/2;
    y = height/2;
    this.mode = mode;
    walkerColor = col;
  }

  void display() {
    stroke(walkerColor,dotSaturation,dotBrightness);
    fill(walkerColor,dotSaturation,dotBrightness);
    ellipse(x,y,dotSize,dotSize);
  }

  void step() {
    float stepSize = (mode == WalkMode.Simple) ? random(0,maxStep) : nextMonteCarlo()*maxStep;
    PVector direction = new PVector(random(-1,1),random(-1,1));
    direction.setMag(stepSize);
    x += direction.x;
    y += direction.y;
    
    if (y > height) {
      y = 0;
    } else if (x > width) {
      x = 0;
    } else if (x < 0) {
      x = width;
    } else if (y < 0) {
      y = height;
    }
  }
  
  // return next Monte Carlo number in range 0 (inclusive) to 1 (exclusive)
  float nextMonteCarlo()
  {
    while (true) {
      float r1 = random(0,1);
      float r2 = random(0,1);
      if (mode == WalkMode.Monte_Exponential && r2 < r1*r1) {
        return r1;
      } else if (mode == WalkMode.Monte_Linear && r2 < r1) {
        return r1;
      }
    }
  }
}