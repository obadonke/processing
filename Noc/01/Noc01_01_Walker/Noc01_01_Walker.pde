Walker w;

void setup() {
  colorMode(HSB,360,100,100);
  size(480, 480);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}