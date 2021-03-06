// Nature of Code - Page 82 Onwards. Incorporating friction into the ball bouncing sim.


import java.util.Random;

final int MaxBalls = 25;
final int RepulsionRange = 60;
final float FrictionCoefficient = 0.1;

Ball[] balls = new Ball[MaxBalls];
Random generator = new Random();
FrictionWellList frictionWells = new FrictionWellList();

void setup() {
  size(640, 360);
  frameRate(60);
  createTheBalls();
}

void draw() {
  fadeBackground();
  drawRepulsionRange();
  drawFrictionWells();

  updateTheBalls();

  drawHelpText();
}

void updateTheBalls() {

  if (mousePressed) {
    PVector mouseLocation = new PVector(mouseX, mouseY);
    if (mouseButton == LEFT) {
      float coefficient = (keyPressed && keyCode == SHIFT) ? -FrictionCoefficient*.5 : FrictionCoefficient; 
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
    Ball b = new Ball(generator, RepulsionRange);
    balls[i] = b;
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

void drawFrictionWells() {
  frictionWells.display();
}

void drawRepulsionRange() {
  stroke(125);
  drawFullHeightLine(RepulsionRange);
  drawFullHeightLine(width-RepulsionRange);
}

void drawFullHeightLine(int x) {
  line(x, 0, x, height);
}