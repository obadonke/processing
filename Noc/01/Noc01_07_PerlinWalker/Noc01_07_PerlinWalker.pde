Walker[] walkers;
int MAX_WALKERS = 10;
// Perlin walker from page 21 of Nature of Code by Daniel Shiffman

void setup() {
  colorMode(HSB,360,100,100);
  size(600, 600);
  walkers = new Walker[MAX_WALKERS];
  for (int i = 0; i < MAX_WALKERS; i++) {
    walkers[i] = new Walker();
  }
  background(0,0,0);
}

void draw() {
  for (int i = 0; i < MAX_WALKERS; i++) {
    walkers[i].step();
    walkers[i].display();
  }
}