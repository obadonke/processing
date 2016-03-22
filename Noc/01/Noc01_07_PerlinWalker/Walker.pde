class Walker {
  float x, y;
  float tx, ty;
  
  Walker() {
    tx = 0;
    ty = 10000;
  }

  void display() {
    fill(0);
    ellipse(x,y,4,4);
  }

  void step() {
    x = map(noise(tx), 0, 1, 0, width);  // x- and y-location mapped from noise
    y = map(noise(ty), 0, 1, 0, height);
    
    tx += 0.01;  // move through Perlin space
    ty += 0.01;
  }
}