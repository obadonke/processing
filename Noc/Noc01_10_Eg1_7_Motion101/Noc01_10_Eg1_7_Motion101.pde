int MAX_MOVERS = 100;

Mover[] mover = new Mover[MAX_MOVERS];

void setup() {
  size(640, 360);

  for (int i = 0; i < MAX_MOVERS; i++) {
    mover[i] = new Mover();
  }
}
void draw() {
  background(255);
  for (int i = 0; i < MAX_MOVERS; i++) {
    mover[i].update();
    mover[i].checkEdges();
    mover[i].display();
  }
}