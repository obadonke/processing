// Pendulum example from Chapter 3 Nature of Code

Pendulum p;

void setup() {
  size(800, 600);
  frameRate(30);
  p = new Pendulum(width/2,10, height-200, PI/4, 40);
}

void draw() {
  background(255);
  p.update();
  p.display();
}