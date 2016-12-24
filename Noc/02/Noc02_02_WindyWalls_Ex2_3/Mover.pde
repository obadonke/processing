// Nature of Code - Exercise 2.3 - Page 77

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  color fillColor;
  
  float mass;
  final int DisplayScale = 16;
  final private int DefaultMass = 1;

  Mover() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = DefaultMass;
    fillColor = color(200,240,0);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);

    resetAcceleration();
  }

  void display() {
    stroke(0);
    fill(fillColor);
    ellipse(location.x, location.y, getDrawSize(), getDrawSize());
  }

  void applyForce(PVector force)
  {
    acceleration.add(PVector.div(force, mass));
  }

  void resetAcceleration() {
    acceleration.mult(0);
  }

  int getDrawSize() {
    return (int)mass*DisplayScale;
  }
}