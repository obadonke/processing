// Nature of Code
// Exercise 1.6 Monte Carlo step size walker.
// Using vectors even though they haven't been introduced yet.

Walker wExp, wNorm;

int expColor = 0;
int linearColor = 160;

void setup() {
  size(480, 240);
  wExp = new Walker(true,expColor);
  wNorm = new Walker(false,linearColor);
  
  background(255);
  fill(0);
  textSize(10);
  text("Random walker Ex 1.6 with Monte Carlo",0,10);
  PVector textPos = new PVector(2*width/3,2*height/3);
  fill(expColor);
  text("Exponential",textPos.x,textPos.y-20);
  fill(linearColor);
  text("Linear",textPos.x,textPos.y-10);
}

void draw() {
  wExp.step();
  wExp.display();
  wNorm.step();
  wNorm.display();
}