// Nature of Code by Daniel Shiffman. Exercise I.8 page 24
// App to allow varying level of detail and falloff for Perlin noise map based on position of mouse.

float xOffset = 0;
float yOffset = 1000;

void setup() {
  colorMode(HSB, 360, 100, 100);
  size(400, 400);
}

void draw() {
  int lod = (int)map(mouseX, 0, width, 1, 9);
  float falloff = map(mouseY, 0, height, 0.0, 1);

  noiseDetail(lod, falloff);
  fillPixels();

  fill(0, 0, 100);
  String settings = String.format("LOD = %d. FallOff = %f [MB = Hue]", lod, falloff);
  text(settings, 0, 20);
}

void fillPixels() {
  loadPixels();
  float curXOffset = xOffset;
  for (int x = 0; x < width; x++) {
    float curYOffset = yOffset;
    for (int y = 0; y < height; y++) {
      float hue = mousePressed ? map(noise(curXOffset, curYOffset), 0, 1, 0, 360): 0; 
      float bright = mousePressed ? 90 : map(noise(curXOffset, curYOffset), 0, 1, 0, 100); 
      pixels[x+y*width] = color(hue, 80, bright);

      curYOffset += 0.01;
    }
    curXOffset += 0.01;
  }
  updatePixels();

  float choice = noise(xOffset+yOffset);
  if (choice < 0.25) {
    xOffset += 0.01;
  } else if (choice < 0.75) {
    xOffset += 0.01;
    yOffset += 0.01;
  } else {
    yOffset += 0.01;
  }
}