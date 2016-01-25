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
    float stepx = random(-3,3);
    float stepy = random(-3,3);
    
    x += stepx;
    y += stepy;
  }
}