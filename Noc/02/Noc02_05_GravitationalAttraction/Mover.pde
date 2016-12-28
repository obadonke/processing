// Based on code samples in Nature of Code by Daniel Shiffman

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  color colour;
  
  float mass;
  float density;  // per pixel
  final private int DefaultMass = 100;
  final private float DefaultDensity = 1;
  final float UniversalGravitationalConstant = 0.1;
  
  Mover() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = DefaultMass;
    density = DefaultDensity;
    colour = color(180,40,40);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    resetAcceleration();
  }
  
  void display() {
    stroke(100,200,100);
    fill(colour);
    int drawSize = (int)(mass/density);
    ellipse(location.x, location.y, drawSize, drawSize);
    ellipse(location.x, location.y, 1, 1);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(PVector.div(force,mass));
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
  
  void applyAttraction(Mover m) {
    // calculate attraction force towards m - see page 95 of Nature of Code
    PVector attraction = m.location.copy();
    attraction.sub(location);
    float distance = constrain(attraction.mag(),50,800);
    attraction.normalize();
    float attractionMag = (UniversalGravitationalConstant*mass*m.mass)/(distance*distance);
    attraction.mult(attractionMag);
    
    applyForce(attraction);
  }
}