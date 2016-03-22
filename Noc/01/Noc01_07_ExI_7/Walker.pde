class Walker {
  float x;
  float y;
  boolean isExponential;
  int walkerColor;
  IRandom stepSizeGen;
  
  Walker(int col, IRandom stepSizeGen) {
    x = width/2;
    y = height/2;
    this.walkerColor = col;
    this.stepSizeGen = stepSizeGen;
  }

  void display() {
    stroke(walkerColor,dotSaturation,dotBrightness);
    fill(walkerColor,dotSaturation,dotBrightness);
    ellipse(x,y,dotSize,dotSize);
  }

  void step() {
    float stepSize = stepSizeGen.getRandom() * maxStep;
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
}