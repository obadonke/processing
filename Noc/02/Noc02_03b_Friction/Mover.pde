// Based on code samples in Nature of Code by Daniel Shiffman

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  color colour;
  
  float mass;
  final int DisplayScale = 16;
  final private int DefaultMass = 1;
  
  Mover() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = DefaultMass;
    colour = color(100,100,100);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    resetAcceleration();
  }
  
  void display() {
    stroke(0);
    fill(colour);
    int drawSize = (int)(mass*DisplayScale);
    ellipse(location.x, location.y, drawSize, drawSize);
    ellipse(location.x, location.y, 1, 1);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(PVector.div(force,mass));
  }
  
  void resetAcceleration() {
    acceleration.mult(0);
  }
}