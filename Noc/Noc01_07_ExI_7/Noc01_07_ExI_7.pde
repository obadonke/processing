// Nature of Code
// Exercise I.7 Introducing Perlin noise into I.6 Monte Carlo walker
// Using vectors even though they haven't been introduced yet.

Walker[] walkers = new Walker[5];
int[] walkerColors = {0,60,120,180,240};

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

  IRandom simpleRandom = new SimpleRandom();

  int walkerHue = walkerColors[0];
  Walker w = new Walker(walkerHue, simpleRandom);
  drawLegendItem("Simple Random", walkerHue, dotBrightness, 2);
  walkers[0] = w;
  
  walkerHue = walkerColors[1];
  w = new Walker(walkerHue, new MonteCarlo(false, simpleRandom));
  drawLegendItem("Monte Carlo Linear", walkerHue, dotBrightness, 3);
  walkers[1] = w;

  walkerHue = walkerColors[2];
  w = new Walker(walkerHue, new MonteCarlo(true, simpleRandom));
  drawLegendItem("Monte Carlo Exponential", walkerHue, dotBrightness, 4);
  walkers[2] = w;
  
  walkerHue = walkerColors[3];
  w = new Walker(walkerHue, new PerlinNoise(1,0.01));
  drawLegendItem("Perlin Noise", walkerHue, dotBrightness, 5);
  walkers[3] = w;
  
  walkerHue = walkerColors[4];
  w = new Walker(walkerHue, new MonteCarlo(false,new PerlinNoise(100,0.01)));
  drawLegendItem("Perlin Noise through Monte Carlo Linear", walkerHue, dotBrightness, 6);
  walkers[4] = w;
  
}

void drawLegendItem(String text, int hue, int brightness, int row)
{
  textSize(txtSize);
  fill(hue, dotSaturation, brightness);
  text(text, 10, txtSize*(1+row));
}

void draw() {
  for (int i = 0; i < walkers.length; i++) {
    walkers[i].step();
    walkers[i].display();
  }
}