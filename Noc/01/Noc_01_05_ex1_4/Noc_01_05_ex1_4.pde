import java.util.*;

// Nature of Code - Exercise 1.4 Paint Splatter

Random generator;
int numDots = 200;
int dotSize = 5;
int dotSpread = 20;
int lastMouseX = 0;
int lastMouseY = 0;
float hue;

void setup() {
  generator = new Random();
  size(640,640);
  colorMode(HSB,360,100,100);
  noStroke();
  nextFill();
  clearCanvas();
  nextColorVariance();
}

void draw() {
  if (lastMouseX == mouseX && lastMouseY == mouseY) return;
  
  if (!mousePressed) {
    return;
  }
  
  if (mouseButton == RIGHT)
  {
    nextFill();
    return;
  }
  
  if (mouseButton == CENTER)
  {
    nextFill();
    clearCanvas();
    return;
  }
  
  nextColorVariance();
  for (int i = 0; i < numDots; i++) {
    float distFromCenter = (float)generator.nextGaussian()*dotSpread;
    float rotation = (float)random(0,PI);
    float offsetX = distFromCenter*cos(rotation);
    float offsetY = distFromCenter*sin(rotation);
    
    ellipse(mouseX + offsetX, mouseY + offsetY,dotSize,dotSize);
    
    lastMouseX = mouseX;
    lastMouseY = mouseY;
  }
}

void clearCanvas() {
  background(0,0,100);
}

void nextFill() {
  hue = random(0,360);
}

void nextColorVariance() {
    float colorVariance = (float)generator.nextGaussian()*3; 
    fill(hue,70+colorVariance,70+colorVariance);
}