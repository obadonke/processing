Walker w;

void setup() {
  size(480, 240);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}