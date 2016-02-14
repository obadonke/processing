// Nature of Code Execrise 1.3 Bouncing ball in 3D

PVector boxBounds;
PVector location;
PVector velocity;
int sphereRadius = 32;
float rotation = PI/6;
float rotationDelta = PI/360;

void setup() {
  size(800, 600,P3D);
  boxBounds = new PVector(600,600,600);
  location = new PVector(100, 100,100);
  velocity = new PVector(sphereRadius/6, sphereRadius/8, sphereRadius/10);
}

void draw() {
  background(255);
  
  location.add(velocity);
  if ((location.x > boxBounds.x-sphereRadius) || (location.x < sphereRadius)) {
    velocity.x = velocity.x * -1;
  }
  if ((location.y > boxBounds.y-sphereRadius) || (location.y < sphereRadius)) {
    velocity.y = velocity.y * -1;
  }
  if ((location.z > boxBounds.z-sphereRadius) || (location.z < sphereRadius)) {
    velocity.z = velocity.z * -1;
  }
  
  sphereDetail(7);
  camera(0,0,-boxBounds.z*2,0,0,0,0,1,0);
  perspective();

  rotateY(rotation);
  rotateX(PI/6);
  rotation += rotationDelta;
  
  stroke(0);

  fill(0,0,240,90);
  pushMatrix();
  // location of sphere is relative to box
  translate(-boxBounds.x/2, -boxBounds.y/2, -boxBounds.z/2);
  translate(location.x, location.y, location.z);
  sphere(sphereRadius);
  popMatrix();
  
  noFill();
  box(boxBounds.x,boxBounds.y,boxBounds.z);
  
  

}