interface IPin {
  PVector getLocation();
  void applyForce(PVector force);
}


class Pin implements IPin {
  float mass;
  float density;
  PVector acceleration;
  PVector location;
  PVector velocity;
  Pin(float x, float y) {
    location = new PVector(x, y);
    mass = 30;
    density = 1;
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
  }
  
  PVector getLocation() {
    return location.copy();
  }
  
  void applyForce(PVector force) {
    acceleration.add(PVector.div(force,mass));
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
 
    resetAcceleration();
  }
  
  void display() {
    stroke(240);
    fill(0,240,0);
    int drawSize = (int)(mass/density);
    ellipse(location.x, location.y, drawSize, drawSize);
    ellipse(location.x, location.y, 1, 1);
  }
  
  void resetAcceleration() {
    acceleration.mult(0);
  }
}