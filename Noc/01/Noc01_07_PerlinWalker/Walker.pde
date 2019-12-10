class Walker {
  float x, y;
  float lastX, lastY;
  float tx, ty;
  float hue;

  Walker() {
    tx = 0+random(3000);
    ty = 10000+random(1000);
    hue = random(360);
    nextCoord();
  }

  void display() {
    int dotColour = (int)hue;
    stroke(dotColour, 90, 100);
    fill(dotColour, 90, 100);
    ellipse(x, y, 4, 4);
    strokeWeight(2);
    line(lastX, lastY, x, y);
  }

  void step() {
    lastX = x;
    lastY = y;
    nextCoord();
    tx += 0.01;  // move through Perlin space
    ty += 0.01;
  }

  void nextCoord() {
    x = map(noise(tx), 0, 1, 0, width);  // x- and y-location mapped from noise
    y = map(noise(ty), 0, 1, 0, height);
  }
}