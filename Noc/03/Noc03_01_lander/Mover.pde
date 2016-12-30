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
  float momentOfInertia;
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
    momentOfInertia = m*m; // fudge just to get value
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);

    angularVelocity += angularAcceleration;
    angle += angularVelocity;

    resetAcceleration();
  }
   
  void applyForce(PVector force) {
    acceleration.add(PVector.div(force,mass));
  }
  
  void applyTorque(float t) {
    angularAcceleration += t/momentOfInertia;
  }

  void applyFriction(float coefficient) {
    if (abs(coefficient) < 0.001) return;
    
    PVector friction = velocity.copy();
    // For now we're assuming friction applies in every direction equally.
    friction.mult(-1);
    friction.normalize();
    friction.mult(coefficient*mass);
    
    applyForce(friction);
  }
  
  void resetAcceleration() {
    acceleration.mult(0);
  }
}  