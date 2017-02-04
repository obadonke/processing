// Nature of Code Exercise 1.8 Acceleration with Mouse Attraction

import java.util.Random;

final boolean DIAGNOSTIC_MODE = false;
final int NUM_VEHICLES = 250;
final int DIAG_NUM_VEHICLES = 1;
final float MAX_SPEED = 6;
final float MAX_ACCELERATION = 0.3;
final float APPROACH_DISTANCE = MAX_SPEED*10;
final float WANDER_ARM_LENGTH = 100;
final float WANDER_RADIUS = WANDER_ARM_LENGTH/2.5;
final boolean ALLOW_ARRIVAL = false;
final boolean DRAW_TRAILS = true;
final boolean DRAW_FIELD_FLOW = false;  // trails will not draw when this is true
final float FIELD_NOISE_SCALE = 0.1;
final float FIELD_NOISE_INCREMENT = 0.01;
final int FIELD_FRAMES_PER_INCREMENT = 10;

final int RESOLUTION = 25;
final float TARGET_LOOK_AHEAD = RESOLUTION;
boolean drawFlow;
boolean drawTrails;
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();

Random generator = new Random();
FlowField flowField;
FlowFieldTarget flowTarget;

void setup() {
  size(1920, 1200);
  frameRate(DIAGNOSTIC_MODE ? 10 : 60);
  drawFlow = DIAGNOSTIC_MODE || DRAW_FIELD_FLOW;
  drawTrails = DRAW_TRAILS && !drawFlow;
  
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
  if (drawTrails) {
    fadeBackground();
  } else {
    resetBackground();
  }
  
  if ((frameCount % FIELD_FRAMES_PER_INCREMENT == 0)) {
    if (random(1) < 0.07) {
      flowField.shiftField(2);
      if (drawTrails) {
        for (int i = 0; i < 5; i++) fadeBackground();
      }
    } else {
      flowField.shiftField(FIELD_NOISE_INCREMENT);
    }
  }
  if (drawFlow) {
      flowField.display();
  }

  updateTheVehicles();
}

void fadeBackground() {
  int totalPixels = width*height;
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int shade = pixels[i] >> 16 & 0xFF;
    if (shade < 20) shade += 1;
    if (shade > 230) shade -= 1;
    pixels[i] = color(shade, shade/2, 0);
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

void mousePressed() {
  fadeBackground();
  save("Screenshot");
  println("Screenshot saved");
}