// Example from Processing, Second Edition. Page 539

int numPixels = 9000;
float[] x = new float[numPixels];
float[] y = new float[numPixels];
PImage img;

void setup() {
  size(300,300);
  img = loadImage("figure300.jpg");  
  
  for (int i = 0; i < numPixels; i++) {
    x[i] = random(width);
    y[i] = random(height);
  }
  stroke(255);
  scale(2);
}

void draw() {
  background(0);
  for (int i = 0; i < numPixels; i++) {
    color c = img.get(int(x[i]),int(y[i]));
    float b = brightness(c);
    float speed = pow(b/255.0, 2)*2 + 0.02;
    stroke(255);
    x[i] += speed;
    if (x[i] > width) {
      x[i] = 0;
      y[i] = random(height);
    }
    point(x[i], y[i]);
  }
}