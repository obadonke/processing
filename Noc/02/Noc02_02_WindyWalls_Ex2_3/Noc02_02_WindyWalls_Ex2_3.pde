// Nature of Code - Exercise 2.3 - Page 77

import java.util.Random;

final int MaxBalls = 20;
final int CeilingHeight = 26;

Ball[] balls = new Ball[MaxBalls];
Random generator = new Random();

void setup() {
  size(640, 480);
  frameRate(30);
  resetBalls();
}

void draw() {
  //background(255);
  fadeBackground();
  
  if (mousePressed)
  {
    resetBalls();
  }
  drawCeiling();
  updateTheBalls();

  drawHelpText();
  
}

void drawCeiling() {
  fill(0);
  noStroke();
  rect(0,CeilingHeight,width,-2);
}

void updateTheBalls() {
  for (int i = 0; i < balls.length; i++) {
    Ball ball = balls[i];
        
    ball.update();
    ball.checkEdges();
    ball.display();
  }
}

void drawHelpText() {
  fill(0);
  textSize(14);
  text("ANY MB = Reset the balls.", 0, 15);
}

void resetBalls() {
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
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