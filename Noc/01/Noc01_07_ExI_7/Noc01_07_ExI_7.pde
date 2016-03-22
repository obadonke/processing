// Nature of Code
// Exercise I.7 Introducing Perlin noise into I.6 Monte Carlo walker
// Using vectors even though they haven't been introduced yet.

Walker[] walkers = new Walker[6];
int[] walkerColors = {0, 60, 120, 180, 240, 300};

int txtSize = 14;

int dotSaturation = 80;
int dotBrightness = 80;
int dotSize = 3;
int maxStep = 5;
int simulationStep = 0;

void setup() {
  colorMode(HSB, 360, 100, 100);
  size(800, 800);

  background(0, 0, 100);
  drawLegendItem("Random walker Ex 1.7 with Monte Carlo", 0, 0, 0);

  IRandom simpleRandom = new SimpleRandom();

  int walkIndex = 0;
  int walkerHue = walkerColors[walkIndex];
  Walker w = new Walker(walkerHue, simpleRandom);
  drawLegendItem("Simple Random", walkerHue, dotBrightness, walkIndex+2);
  walkers[walkIndex] = w;

  ++walkIndex;
  walkerHue = walkerColors[walkIndex];
  w = new Walker(walkerHue, new MonteCarlo(false, simpleRandom));
  drawLegendItem("Monte Carlo Linear", walkerHue, dotBrightness, walkIndex+2);
  walkers[walkIndex] = w;

  ++walkIndex;
  walkerHue = walkerColors[walkIndex];
  w = new Walker(walkerHue, new MonteCarlo(true, simpleRandom));
  drawLegendItem("Monte Carlo Exponential", walkerHue, dotBrightness, walkIndex+2);
  walkers[walkIndex] = w;

  ++walkIndex;
  walkerHue = walkerColors[walkIndex];
  w = new Walker(walkerHue, new PerlinNoise(1, 0.1));
  drawLegendItem("Perlin Noise", walkerHue, dotBrightness, walkIndex+2);
  walkers[walkIndex] = w;

  ++walkIndex;
  walkerHue = walkerColors[walkIndex];
  w = new Walker(walkerHue, new MonteCarlo(false, new PerlinNoise(100, 0.1)));
  drawLegendItem("Perlin Noise through Monte Carlo Linear", walkerHue, dotBrightness, walkIndex+2);
  walkers[walkIndex] = w;

  ++walkIndex;
  walkerHue = walkerColors[walkIndex];
  w = new Walker(walkerHue, new MonteCarlo(true, new PerlinNoise(1000, 1)));
  drawLegendItem("Perlin Noise through Monte Carlo Exponential", walkerHue, dotBrightness, walkIndex+2);
  walkers[walkIndex] = w;
}

void drawLegendItem(String text, int hue, int brightness, int row)
{
  textSize(txtSize);
  fill(hue, dotSaturation, brightness);
  text(text, 10, txtSize*(1+row));
}

void draw() {
  simulationStep++;

  for (int i = 0; i < walkers.length; i++) {
    walkers[i].step();
    walkers[i].display();
  }

  drawStepCount();
}

void drawStepCount() {
  int stepTextSize = 15;
  String simStepText = Integer.toString(simulationStep);
  int textWidth = (int)textWidth(simStepText);
  int xLoc = width-10-textWidth;
  int yLoc = height-10;
  fill(0, 0, 100);
  noStroke();
  rect(xLoc, yLoc-stepTextSize, textWidth+5, stepTextSize+2);
  fill(0, 0, 0);
  textSize(stepTextSize);
  text(simStepText, xLoc, yLoc);
}