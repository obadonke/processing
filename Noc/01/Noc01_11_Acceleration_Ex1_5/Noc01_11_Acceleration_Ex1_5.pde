int MAX_MOVERS = 100;
int totalPixels;
color whitener = color(10,10,10);

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
    int shade = pixels[i] & 0xFF;
    if (shade < 254) shade += 2;
    pixels[i] = color(0,0,shade);
  }
  updatePixels();
  
  for (int i = 0; i < MAX_MOVERS; i++) {
    mover[i].update();
    mover[i].checkEdges();
    mover[i].display();
  }
}