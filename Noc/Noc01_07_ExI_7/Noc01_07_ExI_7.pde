// Nature of Code
// Exercise I.7 Introducing Perlin noise into I.6 Monte Carlo walker
// Using vectors even though they haven't been introduced yet.

Walker wExp, wLinear, wSimple;

int expColor = 0;
int linearColor = 220;
int simpleColor = 60;

int dotSaturation = 80;
int dotBrightness = 80;
int dotSize = 3;
int maxStep = 5;

void setup() {
  colorMode(HSB,360,100,100);
  size(800, 800);
  wExp = new Walker(WalkMode.Monte_Exponential,expColor,new MonteCarloExponential());
  wLinear = new Walker(WalkMode.Monte_Linear,linearColor, new MonteCarloLinear());
  wSimple = new Walker(WalkMode.Simple,simpleColor, new SimpleRandom());
  
  background(0,0,100);
  fill(0,0,0);
  textSize(10);
  text("Random walker Ex 1.7 with Monte Carlo",0,10);
  PVector textPos = new PVector(10,50);
  fill(expColor,dotSaturation,dotBrightness);
  text("Monte Carlo Exponential",textPos.x,textPos.y-20);
  fill(linearColor,dotSaturation,dotBrightness);
  text("Monte Carlo Linear",textPos.x,textPos.y-10);
  fill(simpleColor,dotSaturation,dotBrightness);
  text("Simple Random",textPos.x,textPos.y);
}

void draw() {
  wExp.step();
  wExp.display();
  wLinear.step();
  wLinear.display();
  wSimple.step();
  wSimple.display();
}