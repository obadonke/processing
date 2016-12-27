// Based on code samples in Nature of Code by Daniel Shiffman

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;

  float mass;
  final int DisplayScale = 16;
  final private int DefaultMass = 1;
  color fillColor;
  
  Mover() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = DefaultMass;
    fillColor = color(200,200,200);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    resetAcceleration();
  }
  
  void display() {
    stroke(0);
    fill(fillColor);
    int drawSize = (int)getDisplayDiameter();
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
  
  Circle getBoundingCircle() {
    return new Circle(location, getDisplayDiameter()/2);
  }
 
  float getDisplayDiameter() {
    return mass*DisplayScale;
  }
  
  void applyFriction(float coefficient) {
    if (abs(coefficient) < 0.001) return;
    
    PVector friction = velocity.copy();
    // For now we're assuming friction applies in every direction equally.
    friction.mult(-1);
    friction.normalize();
    friction.mult(coefficient);
    
    applyForce(friction);
  }
  
  void applyFluidResistance(float dragCoefficient, float distParallel, float distPerp) {
    // apply fluid resistance based on given drag coefficient.
    // perp will be taken as working *against* normal of the velocity vector. 
    float speed = velocity.mag();
    float factor = -0.5*dragCoefficient*speed*speed;
    PVector force;
    if (abs(distParallel) > Geometry.ZERO_TOL) { //<>//
      force = velocity.copy();
      force.normalize();
      force.mult(factor*distParallel);
      applyForce(force);
    }
    
    if (abs(distPerp) > Geometry.ZERO_TOL) {
      force = velocity.copy();
      force.rotate(HALF_PI);
      force.normalize();
      force.mult(factor*distPerp);
      applyForce(force); 
    }
  }
  
}