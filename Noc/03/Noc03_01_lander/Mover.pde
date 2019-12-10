// Based on code samples in Nature of Code by Daniel Shiffman

class Mover {
  // this mover is intended to be a base class and has no display representation

  PVector location;
  PVector velocity;
  PVector acceleration;
  float angularAcceleration;
  float angularVelocity;
  float angle;

  float mass;
  float density;  // per pixel

  final private int DefaultMass = 100;
  final private float DefaultDensity = 1;
  
  Mover() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    angularAcceleration = 0;
    angularVelocity = 0;
    angle = 0;
    setMass(DefaultMass);
    density = DefaultDensity;
  }

  void setMass(float m) {
    mass = m;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);

    angularVelocity += angularAcceleration;
    angle += angularVelocity;

    resetAcceleration();
    
    checkEdges();
  }
   
  void applyForce(PVector force) {
    acceleration.add(PVector.div(force,mass));
  }
  
  void applyAngularAcceleration(float t) {
    angularAcceleration += t;
  }

  void applyFriction(float coefficient) {
    if (abs(coefficient) < 0.0001) return;
    
    PVector friction = velocity.copy();
    // For now we're assuming friction applies in every direction equally.
    friction.mult(-1);
    friction.normalize();
    friction.mult(coefficient*mass);
    
    applyForce(friction);
    
    float angularFriction = -angularVelocity*coefficient;
    applyAngularAcceleration(angularFriction);
  }
  
  void resetAcceleration() {
    acceleration.mult(0);
    angularAcceleration = 0;
  }
  
  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}  