// Lander using material from Nature of Code chapter 3

LandingPad[] landingPads = new LandingPad[2];
Lander lander;

void setup() {
  size(800,600);
  landingPads[0] = new LandingPad(100,height-50,150,40);
  landingPads[1] = new LandingPad(width-200,200,150,40);
  lander = new Lander(landingPads[0].location);
}

void draw() {
  background(255);
  for (int i = 0; i < landingPads.length; i++) {
    landingPads[i].draw();
  }
  
  lander.draw();
}