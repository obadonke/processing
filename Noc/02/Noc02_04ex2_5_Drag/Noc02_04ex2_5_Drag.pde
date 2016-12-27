// Nature of Code - Page 82 Onwards. Incorporating friction into the ball bouncing sim.


import java.util.Random;

final int MaxBalls = 10;
final int RepulsionRange = 60;

Ball[] balls = new Ball[MaxBalls];
Random generator = new Random();
Fluid fluid;
int fluidHeight;

void setup() {
  size(640, 1024);
  frameRate(60);
  fluidHeight = 2*height/6;
  createFluid();
  createTheBalls();
}

void createFluid() {
  fluid = new Fluid(0.008, 0, height-fluidHeight, width, fluidHeight);
}

void draw() {
  background(255);

  if (mousePressed) {
    resetTheBalls();
  }
  
  fluid.draw();
  updateTheBalls();
}

void resetTheBalls() {
  for (int i = 0; i < balls.length; i++) {
    balls[i].reset();
  }
}

void updateTheBalls() {
  for (int i = 0; i < balls.length; i++) {
    Ball ball = balls[i];
    calcAndApplyFluidResistance(ball);
    ball.update();
    ball.display();
  }
}

void createTheBalls() {
  int gap = width/(balls.length+1);
  int ballX = gap/2;
  for (int i = 0; i < balls.length; i++) {
    Ball b = new Ball(generator, ballX, height-fluidHeight);
    balls[i] = b;
    ballX += gap;
  }
}

void calcAndApplyFluidResistance(Ball ball) {
  Circle c = ball.getBoundingCircle();
  float ballAreaWithDrag = 0;

  if (fluid.contains(ball.location)) {
    // if at least half the ball is in the fluid, maximum resistance has been achieved
    ball.fillColor = color(0, 200, 0); //<>//
    ballAreaWithDrag = ball.getDisplayDiameter();
  } else {
    PVector[] intersectPts = Geometry.getPointsWhereLineIntersectsCircle(fluid.getSurfaceLine(), c);
    if (intersectPts[0] == intersectPts[1]) {
      // no drag
      ball.fillColor = color(200, 200, 200);
    } else {
      ballAreaWithDrag = PVector.sub(intersectPts[0], intersectPts[1]).mag();
      ball.fillColor = color(200, 200, 0); //<>//
    }
  }

  if (ballAreaWithDrag < Geometry.ZERO_TOL) return;
  
  ball.applyFluidResistance(fluid.dragCoefficient, ballAreaWithDrag,0);
}