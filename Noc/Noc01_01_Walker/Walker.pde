class Walker {
  float x;
  float y;
  
  Walker() {
    x = width/2;
    y = height/2;
  }

  void display() {
    fill(0);
    ellipse(x,y,2,2);
  }

  void step() {
    float stepx = random(-4,4);
    float stepy = random(-4,4);
    
    x += stepx;
    y += stepy;
    
    if (y > height || x > width || x < 0 || y < 0) 
    {
      y = height/2;
      x = width/2;
    }
  }
}