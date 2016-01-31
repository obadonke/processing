class Walker {
  float x;
  float y;
  boolean isExponential;
  int walkerColor;
  
  Walker(boolean exponential, int col) {
    x = width/2;
    y = height/2;
    isExponential = exponential;
    walkerColor = col;
  }

  void display() {
    stroke(walkerColor);
    fill(walkerColor);
    ellipse(x,y,2,2);
  }

  void step() {
    float stepSize = nextMonteCarlo()*4;
    PVector direction = new PVector(random(-1,1),random(-1,1));
    direction.setMag(stepSize);
    x += direction.x;
    y += direction.y;
    
    if (y > height || x > width || x < 0 || y < 0) 
    {
      y = height/2;
      x = width/2;
    }
  }
  
  // return next Monte Carlo number in range 0 (inclusive) to 1 (exclusive)
  float nextMonteCarlo()
  {
    while (true) {
      float r1 = random(0,1);
      float r2 = random(0,1);
      if (isExponential && r2 < r1*r1) {
        return r1;
      } else if (!isExponential && r2 < r1) {
        return r1;
      }
    }
  }
}