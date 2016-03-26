// Nature of Code - Exercise 2.3 - Page 77

import java.util.Random;

final int MaxBalls = 20;
final int RepulsionRange = 60;

Ball[] balls = new Ball[MaxBalls];
Random generator = new Random();

void setup() {
  size(640, 360);
  frameRate(60);
  createTheBalls();
}

void draw() {
  fadeBackground();
  drawRepulsionRange();
  
  if (mousePressed)
  {
    resetBalls();
  }
  updateTheBalls();

  drawHelpText();
}

void updateTheBalls() {
  for (int i = 0; i < balls.length; i++) {
    Ball ball = balls[i];

    ball.update();
    ball.display();
  }
}

void drawHelpText() {
  fill(0);
  textSize(14);
  text("ANY MB = Reset the balls.", 0, 15);
}

void createTheBalls() {
  for (int i = 0; i < balls.length; i++) {
    Ball b = new Ball(generator, RepulsionRange);
    balls[i] = b;
  }
}

void resetBalls() {
  for (int i = 0; i < balls.length; i++) {
    balls[i].reset();
  }
}

void fadeBackground() {
  int totalPixels = width*height;
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int shade = pixels[i] >> 16 & 0xFF;
    if (shade < 254) shade += 1;
    pixels[i] = color(shade, 0, shade);
  }
  updatePixels();
}

void drawRepulsionRange() {
  stroke(125);
  drawFullHeightLine(RepulsionRange);
  drawFullHeightLine(width-RepulsionRange);
  
  stroke(250,125,0);
  drawFullHeightLine(mouseX-RepulsionRange);
  drawFullHeightLine(mouseX+RepulsionRange);
}

void drawFullHeightLine(int x) {
  line(x,0,x,height);
}