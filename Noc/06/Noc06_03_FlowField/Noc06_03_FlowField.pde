// Nature of Code Exercise 1.8 Acceleration with Mouse Attraction

import java.util.Random;

int NUM_VEHICLES = 100;
final float MAX_SPEED = 4;
final float MAX_ACCELERATION = 0.3;
final float APPROACH_DISTANCE = MAX_SPEED*10;
final float WANDER_ARM_LENGTH = 100;
final float WANDER_RADIUS = WANDER_ARM_LENGTH/2.5;
final boolean DRAW_WANDER_DIAG = false;
final boolean ALLOW_ARRIVAL = false;
final float FIELD_NOISE_SCALE = 0.5;
final float FIELD_NOISE_INCREMENT = 1.0;
final int RESOLUTION = 20;

ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();

Random generator = new Random();
FlowField flowField;
FlowFieldTargetFactory ffTargetFactory;

void setup() {
  size(640, 640);
  NUM_VEHICLES = DRAW_WANDER_DIAG ? 1 : NUM_VEHICLES;
  frameRate(DRAW_WANDER_DIAG ? 10 : 60);

  flowField = new FlowField(RESOLUTION);
  ffTargetFactory = new FlowFieldTargetFactory(flowField);
  float vehicleSpacing = (width*height)/NUM_VEHICLES;
  float currentVehicleLocation = vehicleSpacing/2.0;
  for (int i = 0; i < NUM_VEHICLES; i++) {
    ITarget target = ffTargetFactory.createTarget();
    float vy = currentVehicleLocation/width;
    float vx = currentVehicleLocation % width;
    Vehicle v = new Vehicle(vx, vy, 5, target);
    vehicles.add(v);
    currentVehicleLocation += vehicleSpacing;
  }
  resetBackground();
}

void draw() {
  fadeBackground();
  if (frameCount % 100 == 0) {
    flowField.shiftField(FIELD_NOISE_INCREMENT);
    flowField.display();
  }
  
  if (DRAW_WANDER_DIAG || mouseButton == LEFT) {
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
    v.target.updateTarget(v);
    
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