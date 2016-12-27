// Nature of Code - Page 82 Onwards. Incorporating friction into the ball bouncing sim.


import java.util.Random;

final int MaxBalls = 10;
final int RepulsionRange = 60;
final float FrictionCoefficient = 0.1;

Ball[] balls = new Ball[MaxBalls];
Random generator = new Random();
Fluid fluid;

void setup() {
  size(640, 800);
  frameRate(60);
  createFluid();
  createTheBalls();
}

void createFluid() {
  int fluidHeight = 2*height/5;
  fluid = new Fluid(0.1, 0, height-fluidHeight, width, fluidHeight);
}

void draw() {
  background(255);

  fluid.draw();
  updateTheBalls();

  //drawHelpText();
}

void updateTheBalls() {
  for (int i = 0; i < balls.length; i++) {
    Ball ball = balls[i];
    Circle c = ball.getBoundingCircle();
    if (fluid.isCircleInside(c)) {
      ball.fillColor = color(0, 200, 0);
    } else {
      PVector[] intersectPts = Geometry.getPointsWhereLineIntersectsCircle(fluid.getSurfaceLine(), c);
      if (intersectPts[0] == intersectPts[1]) {
        ball.fillColor = color(200, 200, 200);
      } else {
        ball.fillColor = color(200, 200, 0);
      }
    }

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
  int gap = width/(balls.length+1);
  int ballX = gap/2;
  for (int i = 0; i < balls.length; i++) {
    Ball b = new Ball(generator, ballX);
    balls[i] = b;
    ballX += gap;
  }
}

void drawFullWidthLine(int x) {
  line(0, x, width, x);
}