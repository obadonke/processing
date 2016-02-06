// Nature of Code
// Exercise I.7 Introducing Perlin noise into I.6 Monte Carlo walker
// Using vectors even though they haven't been introduced yet.

Walker[] walkers = new Walker[4];

int expColor = 0;
int linearColor = 220;
int simpleColor = 60;
int perlinColor = 100;

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
  Walker w = new Walker(simpleColor, simpleRandom);
  drawLegendItem("Simple Random", simpleColor, dotBrightness, 2);
  walkers[0] = w;
  
  w = new Walker(linearColor, new MonteCarlo(false, simpleRandom));
  drawLegendItem("Monte Carlo Linear", linearColor, dotBrightness, 3);
  walkers[1] = w;

  w = new Walker(expColor, new MonteCarlo(true, simpleRandom));
  drawLegendItem("Monte Carlo Exponential", expColor, dotBrightness, 4);
  walkers[2] = w;
  
  w = new Walker(perlinColor, new PerlinNoise(1,0.01));
  drawLegendItem("Perlin Noise", perlinColor, dotBrightness, 5);
  walkers[3] = w;
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