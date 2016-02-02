Walker w;

// Perlin walker from page 21 of Nature of Code by Daniel Shiffman

void setup() {
  size(480, 240);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}