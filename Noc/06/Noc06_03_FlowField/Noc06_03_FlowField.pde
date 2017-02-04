// Nature of Code Exercise 1.8 Acceleration with Mouse Attraction

import java.util.Random;

final boolean DIAGNOSTIC_MODE = false;
final int NUM_VEHICLES = 150;
final int DIAG_NUM_VEHICLES = 1;
final float MAX_SPEED = 6;
final float MAX_ACCELERATION = 0.3;
final float APPROACH_DISTANCE = MAX_SPEED*10;
final float WANDER_ARM_LENGTH = 100;
final float WANDER_RADIUS = WANDER_ARM_LENGTH/2.5;
final boolean ALLOW_ARRIVAL = false;
final boolean DRAW_TRAILS = true;
final boolean ALWAYS_DRAW_FIELD_FLOW = false;
final float FIELD_NOISE_SCALE = 0.01;
final float FIELD_NOISE_INCREMENT = 0.1;
final int FIELD_FRAMES_PER_INCREMENT = 10;

final int RESOLUTION = 20;
final float TARGET_LOOK_AHEAD = RESOLUTION;

ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();

Random generator = new Random();
FlowField flowField;
FlowFieldTarget flowTarget;

void setup() {
  size(640, 640);
  frameRate(DIAGNOSTIC_MODE ? 10 : 60);

  flowField = new FlowField(RESOLUTION);
  flowTarget = new FlowFieldTarget(flowField);
  createVehicles();
  resetBackground();
}

void createVehicles() {
  int numVehicles = DIAGNOSTIC_MODE ? DIAG_NUM_VEHICLES : NUM_VEHICLES;
  float vehicleSpacing = (width*height)/numVehicles;
  println("Vehicle spacing = " + vehicleSpacing + " % width = " + (vehicleSpacing % width));
  float currentVehicleOffset = 0;
  for (int i = 0; i < numVehicles; i++) {
    float vehicleLocation = currentVehicleOffset + random(vehicleSpacing/1.5);
    float vy = floor(vehicleLocation/width);
    float vx = vehicleLocation % width;
    Vehicle v = new Vehicle(vx, vy, 5, flowTarget);
    vehicles.add(v);
    currentVehicleOffset += vehicleSpacing;
  }
}

void draw() {
  if (DRAW_TRAILS) {
    fadeBackground();
  } else {
    resetBackground();
  }
  
  if (ALWAYS_DRAW_FIELD_FLOW || (frameCount % FIELD_FRAMES_PER_INCREMENT == 0)) {
    flowField.shiftField(FIELD_NOISE_INCREMENT);
    flowField.display();
  }

  updateTheVehicles();
}

void fadeBackground() {
  int totalPixels = width*height;
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int shade = pixels[i] >> 16 & 0xFF;
    if (shade < 250) shade += 1;
    pixels[i] = color(shade, 0, 0);
  }
  updatePixels();
}

void resetBackground() {
  background(200, 0, 0);
}

void updateTheVehicles() {
  for (Vehicle v : vehicles) {
    v.update();
    v.checkEdges();
    v.display();
  }
}

void drawHelpText() {
  fill(255);
  textSize(14);
  text("NO MB = Attraction proportional to distance from mouse.", 0, 20);
  text("LEFT MB = Inverse.", 0, 40);
}