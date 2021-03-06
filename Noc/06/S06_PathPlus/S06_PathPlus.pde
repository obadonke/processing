import java.util.Iterator;

final boolean DIAGNOSTIC_MODE = false;
final int NUM_VEHICLES = 200;
final int DIAG_NUM_VEHICLES = 4;
final float MAX_SPEED = 5;
final float MAX_ACCELERATION = 0.4;
final float APPROACH_DISTANCE = MAX_SPEED*10;
final float ROAD_RADIUS = 30;
final float LOOK_AHEAD = ROAD_RADIUS*2;
final float MIN_SEPARATION = 20;

final boolean ALLOW_ARRIVAL = true;
final boolean ALLOW_REVERSE = true;
final boolean DRAW_PATH = true;
float noiseOffset = 1000;
float noiseWidth = 2;
float noisePan = 0.002;
final int NUM_SEGMENTS = 100;
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();
Path path;
SeparationBehaviour separationBehaviour = new SeparationBehaviour(vehicles);

void setup() {
  size(640, 640);
  frameRate(DIAGNOSTIC_MODE ? 20 : 60);
  resetBackground();
  ArrayList<PVector> points = createTrack();
  
  path = new Path(points, ROAD_RADIUS);
  
  updatePath();
  int numVehicles = DIAGNOSTIC_MODE ? DIAG_NUM_VEHICLES : NUM_VEHICLES;
  ITarget target = new PathTarget(path);
  for (int i = 0; i < numVehicles; i++) {
    Vehicle v = new Vehicle(random(width), random(height), 5, target, separationBehaviour);
    vehicles.add(v);
  }
}

void draw() {
  updatePath();
  resetBackground();
  if (DRAW_PATH) path.display();
  updateTheVehicles();
  
}

void resetBackground() {
  background(200, 0, 0);
}

void updatePath() {
  noiseOffset += noisePan;
  ArrayList<PVector> points = createTrack();
  path.setPoints(points);
}

void updateTheVehicles() {
  for (Vehicle v : vehicles) {
    v.applyBehaviours();
    v.update();
    if (DIAGNOSTIC_MODE) {
      v.target.display();
    }
    v.checkEdges();
    v.display();
  }
}

ArrayList<PVector> createTrack() {
  ArrayList<PVector> points = new ArrayList<PVector>();
  float maxRadius = min(width, height) * 0.45;
  float segWidth = TWO_PI/NUM_SEGMENTS;
  for (int i = 0; i < NUM_SEGMENTS; i++) {
    float segAngle = segWidth*i;
    float r = map(noise(noiseOffset+map(sin(segAngle),-1,1,0,noiseWidth)),0,1,maxRadius/2,maxRadius);
    float x = width/2 + r*cos(segAngle);
    float y = height/2 + r*sin(segAngle);
    points.add(new PVector(x, y));
  }
  return points;
}