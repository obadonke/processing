// Nature of Code - different take on friction well idea


import java.util.Random;

final int MaxBalls = 20;
final float FrictionCoefficient = 0.03;
Rect sceneBounds;
PVector scale;

Ball[] balls = new Ball[MaxBalls];
Random generator = new Random();

void setup() {
  size(800, 800);
  //frameRate(60);
  createBalls();
  sceneBounds = new Rect(0,0,width,height);
  scale = new PVector(1,1);
}

void draw() {
  fadeBackground();
  updateBalls();
  setScale();
  drawBalls();
}

void createBalls() {
  balls[0] = new Ball(width/2, height/2, 1200);
  balls[0].density = 5;
  balls[1] = new Ball(width/8, height/8, 20);
  balls[2] = new Ball(4*width/8, 7*height/8, 40);
  balls[3] = new Ball(5*width/8, height/5, 150);
  balls[3].density = 3;
  balls[4] = new Ball(30+(5*width/8), height/5, 10);
  balls[5] = new Ball(7*width/8, 4*height/5, 150);
  balls[5].density = 3;
  balls[6] = new Ball(30+(7*width/8), 10+(4*height/5), 10);
  
  for (int i = 7; i < MaxBalls; i++) {
    balls[i] = new Ball((int)random(10,width-10), (int)random(10,height-10), (int)(10+random(5)));
  }
}

void updateBalls() {
  for (int i = 0; i < balls.length; i++) {
    Ball ballA = balls[i];
    for (int j = i+1; j < balls.length; j++) {
      Ball ballB = balls[j];
      ballA.applyAttraction(ballB);
      ballB.applyAttraction(ballA);
    }
    ballA.update();
    
    adjustSceneBoundsForBall(ballA);
  }
}

void adjustSceneBoundsForBall(Ball ball) {
  Rect bb = ball.getBoundingBox();
  PVector sceneBR = sceneBounds.getBottomRight();
  PVector ballBR = bb.getBottomRight();
  
  sceneBounds.x = min(sceneBounds.x, bb.x);
  sceneBounds.y = min(sceneBounds.y, bb.y);
  
  sceneBounds.width = (int)max(sceneBR.x, ballBR.x) - sceneBounds.x;
  sceneBounds.height = (int)max(sceneBR.y, ballBR.y) - sceneBounds.y; 
}

void setScale() {
  if (sceneBounds.x == 0 && sceneBounds.y == 0 && sceneBounds.width == width && sceneBounds.height == height) {
    scale = new PVector(1,1);
  }
  
  scale = new PVector(width/(float)sceneBounds.width, height/(float)sceneBounds.height);
  println("sceneWidth = " + sceneBounds.width + " scaleX = " + scale.x);
}

void drawBalls() {
  pushMatrix();
  translate(-sceneBounds.x, -sceneBounds.y);
  scale(scale.x, scale.y);
  
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
    if (red < 190) red += 1;
    if (red > 210) red -= 1;
    if (blue > 200) blue -= 1;
    if (blue < 180) blue += 1;
    if (green > 210) green -= 1;
    if (green < 190) green += 1;
    pixels[i] = color(red, green, blue);
  }
  updatePixels();
}