int MAX_MOVERS = 150;
int totalPixels;
color whitener = color(10, 10, 10);

Mover[] mover = new Mover[MAX_MOVERS];

void setup() {
  size(640, 640);
  background(255);
  totalPixels = width*height;
  strokeWeight(0.5);

  for (int i = 0; i < MAX_MOVERS; i++) {
    mover[i] = new Mover();
  }
}
void draw() {
  fadeCanvas();

  for (int i = 0; i < MAX_MOVERS; i++) {
    mover[i].update();
    mover[i].checkEdges();
    mover[i].display();
  }
}

void fadeCanvas() {
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int pixel = pixels[i];
    int blue = pixel & 0xFF;
    int green = (pixel >> 8) & 0xFF;
    int red = (pixel >> 16) & 0xFF; 
    if (blue > 1) blue -= 2;
    
    if (green > 40) { 
      green -= 2;
    } else if (green < 20) green += 1;
    
    if (red > 80) {
      red -= 2;
    } else if (red < 40) red += 1;

    pixels[i] = color(red, green, blue);
  }
  updatePixels();
}