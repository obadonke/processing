// Nature of Code Exercise 1.8 Acceleration with Mouse Attraction

import java.util.Random;


int MAX_MOVERS = 40;
int totalPixels;
final float distanceStep = 15;
final float maxDistanceRange = 12;

Mover[] mover = new Mover[MAX_MOVERS];
Random generator = new Random();

void setup() {
  size(640, 640);
  background(255);
  totalPixels = width*height;

  for (int i = 0; i < MAX_MOVERS; i++) {
    mover[i] = new Mover();
  }
}
void draw() {

  fadeBackground();

  drawDistanceSteps();

  updateTheMovers();

  drawHelpText();
}

void fadeBackground() {
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int shade = pixels[i] >> 16 & 0xFF;
    if (shade < 254) shade += 1;
    pixels[i] = color(shade, 0, 0);
  }
  updatePixels();
}

void drawDistanceSteps() {
  for (int i = 1; i <= maxDistanceRange; i++) {
    stroke(240, 240, 0);
    strokeWeight(1);
    noFill();
    ellipse(mouseX, mouseY, distanceStep*i*2, distanceStep*i*2);
  }
}

void updateTheMovers() {
  for (int i = 0; i < MAX_MOVERS; i++) {
    mover[i].update();
    mover[i].checkEdges();
    mover[i].display();
  }
}

void drawHelpText() {
  fill(255);
  textSize(14);
  text("NO MB = Attraction proportional to distance from mouse.", 0, 20);
  text("LEFT MB = Inverse.", 0, 40);
}