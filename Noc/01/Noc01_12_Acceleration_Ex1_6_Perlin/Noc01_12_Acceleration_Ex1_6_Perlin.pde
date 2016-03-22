// Nature of Code Exercise 1.6 Acceleration using Perlin noise

int MAX_MOVERS = 60;
int totalPixels;

Mover[] mover = new Mover[MAX_MOVERS];

void setup() {
  size(640, 640);
  background(255);
  totalPixels = width*height;
  
  for (int i = 0; i < MAX_MOVERS; i++) {
    mover[i] = new Mover();
  }
}
void draw() {
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int shade = pixels[i] >> 16 & 0xFF;
    if (shade < 254) shade += 1;
    pixels[i] = color(shade,0,0);
  }
  updatePixels();
  
  for (int i = 0; i < MAX_MOVERS; i++) {
    mover[i].update();
    mover[i].checkEdges();
    mover[i].display();
  }
}