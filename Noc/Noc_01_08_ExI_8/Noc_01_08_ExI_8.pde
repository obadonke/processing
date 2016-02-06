// Nature of Code by Daniel Shiffman. Exercise I.8 page 24
// App to allow varying level of detail and falloff for Perlin noise map based on position of mouse.

float offset = 0;

void setup() {
  size(800, 800);
}

void draw() {
  int lod = (int)map(mouseX, 0, width, 1, 9);
  float falloff = map(mouseY, 0, height, 0.0, 1);
  
  noiseDetail(lod, falloff);
  fillPixels();
  
  fill(255);
  String settings = String.format("LOD = %d. FallOff = %f",lod, falloff);
  text(settings,0,20);
}

void fillPixels() {
  loadPixels();
  float xOffset = offset;
  for (int x = 0; x < width; x++) {
    float yOffset = offset;
    for (int y = 0; y < height; y++) {
      float bright = map(noise(xOffset,yOffset),0,1,0,255); 
      pixels[x+y*width] = color(bright);
      
      yOffset += 0.01;
    }
    xOffset += 0.01;
  }
  updatePixels();
  offset+= 0.01;
}