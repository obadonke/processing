// Nature of Code Exercise 2.1 Hellium Balloons affected by Wind

import java.util.Random;

final int MaxBalloons = 20;
final int CeilingHeight = 26;
WindGenerator windGenerator = new WindGenerator(0.3, 50);

Balloon[] balloons = new Balloon[MaxBalloons];
Random generator = new Random();

void setup() {
  size(640, 640);
  frameRate(25);
  resetBalloons();
}

void draw() {
  background(255);
  
  if (mousePressed)
  {
    resetBalloons();
  }
  drawCeiling();
  updateTheBalloons();

  drawHelpText();
  
}

void drawCeiling() {
  fill(0);
  noStroke();
  rect(0,CeilingHeight,width,-2);
}

void updateTheBalloons() {
  for (int i = 0; i < balloons.length; i++) {
    Balloon balloon = balloons[i];
    
    if (balloonCollidesWithCeiling(balloon))
    {
      balloon.bounceOffCeiling(CeilingHeight);
    }
    
    applyWindToBalloon(balloon);
    balloon.update();
    balloon.checkEdges();
    balloon.display();
  }
}

void drawHelpText() {
  fill(0);
  textSize(14);
  text("ANY MB = Reset the balloons.", 0, 15);
}

void resetBalloons() {
  windGenerator.setSeed(random(10000));
  for (int i = 0; i < balloons.length; i++) {
    balloons[i] = new Balloon();
  }
}

boolean balloonCollidesWithCeiling(Balloon balloon) {
  return balloon.location.y - balloon.radius <= CeilingHeight;
}


void applyWindToBalloon(Balloon balloon) {
  PVector windForce = windGenerator.getWindForce();
  balloon.applyForce(windForce);
}