// Nature of Code
// Exercise I.7 Introducing Perlin noise into I.6 Monte Carlo walker
// Using vectors even though they haven't been introduced yet.

Walker wExp, wLinear, wSimple;

int expColor = 0;
int linearColor = 220;
int simpleColor = 60;
int txtSize = 14;

int dotSaturation = 80;
int dotBrightness = 80;
int dotSize = 3;
int maxStep = 5;

void setup() {
  colorMode(HSB, 360, 100, 100);
  size(800, 800);

  background(0, 0, 100);
  drawLegendItem("Random walker Ex 1.7 with Monte Carlo", 0, 0, 0);

  wSimple = new Walker(WalkMode.Simple, simpleColor, new SimpleRandom());
  drawLegendItem("Simple Random", simpleColor, dotBrightness, 2);

  wLinear = new Walker(WalkMode.Monte_Linear, linearColor, new MonteCarloLinear());
  drawLegendItem("Monte Carlo Linear", linearColor, dotBrightness, 3);

  wExp = new Walker(WalkMode.Monte_Exponential, expColor, new MonteCarloExponential());
  drawLegendItem("Monte Carlo Exponential", expColor, dotBrightness, 4);
}

void drawLegendItem(String text, int hue, int brightness, int row)
{
  textSize(txtSize);
  fill(hue, dotSaturation, brightness);
  text(text, 10, txtSize*(1+row));
}

void draw() {
  wExp.step();
  wExp.display();
  wLinear.step();
  wLinear.display();
  wSimple.step();
  wSimple.display();
}