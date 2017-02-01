// Nature of Code Exercise 1.8 Acceleration with Mouse Attraction

import java.util.Random;

final int NUM_VEHICLES = 30;
final float MAX_SPEED = 6;
final float MAX_ACCELERATION = 0.6;
final float APPROACH_DISTANCE = MAX_SPEED*10;
final float WANDER_ARM_LENGTH = 100;
final float WANDER_RADIUS = WANDER_ARM_LENGTH/2.0;

ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();
Random generator = new Random();

void setup() {
  size(640, 640);
  background(255);

  for (int i = 0; i < NUM_VEHICLES; i++) {
    vehicles.add(new Vehicle(random(width), random(height), 5));
  }
}
void draw() {
  fadeBackground();
  updateTheVehicles();
}

void fadeBackground() {
  int totalPixels = width*height;
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
    v.wander();
    v.update();
    v.checkEdges();
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