// Nature of Code - Exercise 2.3 - Page 77

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;

  float mass;
  final int DisplayScale = 16;
  final private int DefaultMass = 1;
  
  Mover() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = DefaultMass;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    resetAcceleration();
  }
  
  void display() {
    stroke(0);
    fill(175);
    int drawSize = (int)(mass*DisplayScale);
    ellipse(location.x, location.y, drawSize, drawSize);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(PVector.div(force,mass));
  }
  
  void resetAcceleration() {
    acceleration.mult(0);
  }
}