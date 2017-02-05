// Nature of Code Exercise 1.8 Acceleration with Mouse Attraction

final boolean DIAGNOSTIC_MODE = false;
final int NUM_VEHICLES = 30;
final int DIAG_NUM_VEHICLES = 2;
final float MAX_SPEED = 6;
final float MAX_ACCELERATION = 0.3;
final float APPROACH_DISTANCE = MAX_SPEED*10;
final float LOOK_AHEAD = MAX_SPEED*8;
final boolean ALLOW_ARRIVAL = false;
float noiseOffset = 1000;
float noiseScale = 0.003;
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();
SimplePath path;

void setup() {
  size(640, 640);
  frameRate(DIAGNOSTIC_MODE ? 10 : 60);
  resetBackground();
  path = new SimplePath(new PVector(0, height/3), new PVector(width, 2*height/3), 30);
  updatePath();
  int numVehicles = DIAGNOSTIC_MODE ? DIAG_NUM_VEHICLES : NUM_VEHICLES;
  ITarget target = new PathTarget(path);
  for (int i = 0; i < numVehicles; i++) {
    Vehicle v = new Vehicle(random(width), random(height), 5, target);
    vehicles.add(v);
  }
}

void draw() {
  updatePath();
  resetBackground();
  path.display();
  updateTheVehicles();
  
}

void resetBackground() {
  background(200, 0, 0);
}

void updatePath() {
  //path.start.y = map(noise(noiseOffset),0,1,0, height);
  //path.end.y = map(noise(noiseOffset*2),0,1,0, height);
  //noiseOffset += noiseScale;
}

void updateTheVehicles() {
  for (Vehicle v : vehicles) {
    v.update();
    if (DIAGNOSTIC_MODE) {
      v.target.display();
    }
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