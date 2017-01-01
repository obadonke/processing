// Pendulum example from Chapter 3 Nature of Code

final int NumPendulums = 5;

Pendulum[] p = new Pendulum[NumPendulums];

void setup() {
  size(800, 600);
  frameRate(30);
  int lengthDelta = (height-100)/NumPendulums;
  int pendulumLength = lengthDelta;
  for (int i = 0; i < NumPendulums; i++) {
     p[i] = new Pendulum(width/2, 10, pendulumLength, PI/4);
     pendulumLength += lengthDelta;
  }
}

void draw() {
  background(255);
  for (int i = 0; i < NumPendulums; i++) {
    p[i].update();
    p[i].display();
  }
}