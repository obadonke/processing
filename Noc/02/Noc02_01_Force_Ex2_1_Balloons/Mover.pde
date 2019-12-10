// Nature of Code - page 70 Exercise 2.1

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int radius;
  
  Mover() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    radius = 12;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    resetAcceleration();
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    noFill();
    ellipse(location.x, location.y, radius*2, radius*2);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = height;
    }
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void resetAcceleration() {
    acceleration.mult(0);
  }
}