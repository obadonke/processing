class Walker {
  float x;
  float y;

  Walker() {
    x = width/2;
    y = height/2;
  }

  void display() {
    stroke(0);
    point(x, y);
  }

  void step() {
    float stepx = random(-2,2);
    float stepy = random(-2,2);
    
    x += stepx;
    y += stepy;
  }
}