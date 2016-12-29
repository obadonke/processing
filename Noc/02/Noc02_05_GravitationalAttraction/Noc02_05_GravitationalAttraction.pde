// Nature of Code - different take on friction well idea


import java.util.Random;

final int MaxBalls = 20;
final float FrictionCoefficient = 0.03;
final float MaxDistanceConstraint = 200;

Rect sceneBounds;
float scale;

Ball[] balls = new Ball[MaxBalls];
Random generator = new Random();

void setup() {
  size(800, 800);
  //frameRate(60);
  createBalls();
  sceneBounds = new Rect(0,0,width,height);
  scale = 1;
  background(60,40,40);
}

void draw() {
  fadeBackground();
  updateBalls();
  setScale();
  drawBalls();
  drawInfoText();
}

void createBalls() {
  balls[0] = new Ball(width/2, height/2, 2400, 10);
  balls[1] = new Ball(width/8, height/8, 40, 2);
  balls[2] = new Ball(4*width/8, 7*height/8, 40);
  balls[3] = new Ball(5*width/8, height/5, 250, 5);
  balls[4] = new Ball(30+(5*width/8), height/5, 40, 2);
  balls[5] = new Ball(7*width/8, 4*height/5, 250, 5);
  balls[6] = new Ball(30+(7*width/8), 10+(4*height/5), 40, 2);
  
  for (int i = 7; i < MaxBalls; i++) {
    balls[i] = new Ball((int)random(50,width-50), (int)random(50,height-50), (int)(40+random(10)), 3);
  }
}

void updateBalls() {
  for (int i = 0; i < balls.length; i++) {
    Ball ballA = balls[i];
    for (int j = i+1; j < balls.length; j++) {
      Ball ballB = balls[j];
      ballA.applyAttraction(ballB,MaxDistanceConstraint);
      ballB.applyAttraction(ballA,MaxDistanceConstraint);
    }
    ballA.update();
    
    adjustSceneBoundsForBall(ballA);
  }
}

void adjustSceneBoundsForBall(Ball ball) {
  Rect bb = ball.getBoundingBox();
  PVector sceneBR = sceneBounds.getBottomRight();
  PVector ballBR = bb.getBottomRight();
  
  // always shift same amount in X and Y for consistency
  int bbMin = min(bb.x, bb.y);
  
  sceneBounds.x = min(sceneBounds.x, bbMin);
  sceneBounds.y = min(sceneBounds.y, bbMin);
  
  sceneBounds.width = (int)max(sceneBR.x, ballBR.x) - sceneBounds.x;
  sceneBounds.height = (int)max(sceneBR.y, ballBR.y) - sceneBounds.y; 
}

void setScale() {
  float lastScale = scale;
  scale = min(width/(float)sceneBounds.width, height/(float)sceneBounds.height);
  
  if (abs(lastScale-scale) > Geometry.ZERO_TOL) {
    //println();
    background(60,40,40);
  }
}

void drawBalls() {
  pushMatrix();
  scale(scale, scale);
  translate(-sceneBounds.x, -sceneBounds.y);
  
  for (int i = 0; i < balls.length; i++) {
    balls[i].display();
  }
  
  popMatrix();
}

void fadeBackground() {
  int totalPixels = width*height;
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int red = pixels[i] >> 16 & 0xFF;
    int green = pixels[i] >> 8 & 0xFF;
    int blue = pixels[i] & 0xFF;
    if (red < 160) red += 1;
    if (red > 210) red -= 1;
    if (blue > 200) blue -= 1;
    if (blue < 160) blue += 1;
    if (green > 210) green -= 1;
    if (green < 160) green += 1;
    pixels[i] = color(red, green, blue);
  }
  updatePixels();
}

void drawInfoText() {
  fill(255);
  textSize(14);
  text("bounds " + sceneBounds.ToString() + " scale " + scale, 0, height-5);
}