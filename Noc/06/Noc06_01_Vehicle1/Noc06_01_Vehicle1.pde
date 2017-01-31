// Nature of Code Exercise 1.8 Acceleration with Mouse Attraction

import java.util.Random;

int NUM_VEHICLES = 3;
float MAX_SPEED = 6;
float MAX_ACCELERATION = 1;
int totalPixels;
final float distanceStep = 15;
final float maxDistanceRange = 12;

ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();
Random generator = new Random();

void setup() {
  size(640, 640);
  background(255);
  totalPixels = width*height;

  for (int i = 0; i < NUM_VEHICLES; i++) {
    vehicles.add(new Vehicle(random(width), random(height), 5));
  }
}
void draw() {
  fadeBackground();
  updateTheVehicles();
}

void fadeBackground() {
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int shade = pixels[i] >> 16 & 0xFF;
    if (shade < 254) shade += 1;
    pixels[i] = color(shade, 0, 0);
  }
  updatePixels();
}


void updateTheVehicles() {
  PVector target = new PVector(mouseX, mouseY);
  for (Vehicle v: vehicles) {
    v.seek(target);
    v.update();
    //v.checkEdges();
    v.display();
    
    PVector vector = PVector.mult(v.velocity,-50);
    target = PVector.add(v.location,vector);
  }
}

void drawHelpText() {
  fill(255);
  textSize(14);
  text("NO MB = Attraction proportional to distance from mouse.", 0, 20);
  text("LEFT MB = Inverse.", 0, 40);
}