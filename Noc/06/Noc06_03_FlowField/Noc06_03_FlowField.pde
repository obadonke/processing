// Nature of Code Exercise 1.8 Acceleration with Mouse Attraction

import java.util.Random;

int NUM_VEHICLES = 30;
final float MAX_SPEED = 4;
final float MAX_ACCELERATION = 0.3;
final float APPROACH_DISTANCE = MAX_SPEED*10;
final float WANDER_ARM_LENGTH = 100;
final float WANDER_RADIUS = WANDER_ARM_LENGTH/2.5;
final boolean DRAW_WANDER_DIAG = false;
final float NOISE_SCALE = 0.03;
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
  for (int i = 0; i < NUM_VEHICLES; i++) {
    ITarget target = ffTargetFactory.createTarget();
    Vehicle v = new Vehicle(random(width), random(height), 5, target);
    vehicles.add(v);
  }
  resetBackground();
}

void draw() {
  fadeBackground();
  //flowField.display();
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

void resetBackground() {
  background(200, 0, 0);
}

void updateTheVehicles() {
  for (Vehicle v : vehicles) {
    v.target.updateTarget(v);
    if (DRAW_WANDER_DIAG) {
      v.target.displayTarget();
    }

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

void mouseReleased() {
  resetBackground();
  flowField.shiftField(1.0);
}