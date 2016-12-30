// Astroid thingy based on Nature of Code chapter 3

Lander lander;

void setup() {
  size(800, 600);
  lander = new Lander(new PVector(width/4, height/2));
}

void draw() {
  background(255);

  lander.draw();
}


void keyPressed() {
  if (key == 'A' || key == 'a') {
    lander.leftThrust(true);
  } else if (key == 'D' || key == 'd') {
    lander.rightThrust(true);
  }
}

void keyReleased() {
  if (key == 'A' || key == 'a') {
    lander.leftThrust(false);
  } else if (key == 'D' || key == 'd') {
    lander.rightThrust(false);
  }
}