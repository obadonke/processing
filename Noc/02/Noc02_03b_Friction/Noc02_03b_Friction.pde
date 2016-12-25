// Nature of Code - different take on friction well idea


import java.util.Random;

final int MaxBalls = 25;
final float FrictionCoefficient = 0.05;

Ball[] balls = new Ball[MaxBalls];
Random generator = new Random();
FrictionWellList frictionWells = new FrictionWellList();

void setup() {
  size(640, 640);
  frameRate(60);
  createTheBalls();
}

void draw() {
  fadeBackground();
  drawFrictionWells();

  updateTheBalls();

  drawHelpText();
}

void updateTheBalls() {

  if (mousePressed) {
    PVector mouseLocation = new PVector(mouseX, mouseY);
    if (mouseButton == LEFT) {
      float coefficient = (keyPressed && keyCode == SHIFT) ? -FrictionCoefficient : FrictionCoefficient; 
      frictionWells.addAt(mouseLocation, coefficient);
    } else if (mouseButton == RIGHT) {
      frictionWells.removeAt(mouseLocation);
    }
  }

  for (int i = 0; i < balls.length; i++) {
    Ball ball = balls[i];
    ball.applyFriction(frictionWells.sumFrictionCoefficientAt(ball.location));
    ball.update();
    ball.display();
  }
}

void drawHelpText() {
  fill(0);
  textSize(14);
  text("Left MB = add a friction well. SHIFT LMB = Propel. Right MB = remove a friction well", 0, 15);
}

void createTheBalls() {
  for (int i = 0; i < balls.length; i++) {
    Ball b = new Ball(generator);
    balls[i] = b;
  }
}

void fadeBackground() {
  int totalPixels = width*height;
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int red = pixels[i] >> 16 & 0xFF;
    int green = pixels[i] >> 8 & 0xFF;
    int blue = pixels[i] & 0xFF;
    if (red < 254) red += 1;
    if (blue > 20) blue -= 1;
    if (green < 254) green += 1;
    pixels[i] = color(red, green, blue);
  }
  updatePixels();
}

void drawFrictionWells() {
  frictionWells.display();
}

void drawFullHeightLine(int x) {
  line(x, 0, x, height);
}