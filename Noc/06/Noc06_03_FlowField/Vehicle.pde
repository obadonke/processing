// Nature of Code - page 58-59

class Vehicle implements IVehicle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float maxAcceleration;
  float size = 3;

  ITarget target;

  private final ITarget myTargetIdentity = new ITarget() {
    void displayTarget() {
    }
    void updateTarget(IVehicle v) {
    }
    PVector getTargetLocation() { 
      return Vehicle.this.location;
    }
  };

  ITarget asTarget() {
    return myTargetIdentity;
  }

  Vehicle(float x, float y, float r, ITarget target) {
    size = r;
    location = new PVector(x, y);
    velocity = PVector.random2D();
    maxSpeed = MAX_SPEED;
    maxAcceleration = MAX_ACCELERATION;
    acceleration = new PVector(0, 0);
    this.target = target;
  }

  void update() {
    seek(target.getTargetLocation());

    acceleration.limit(maxAcceleration);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);

    float dist = desired.mag();
    if (ALLOW_ARRIVAL && dist < APPROACH_DISTANCE) {
      float speed = map(dist, 0, APPROACH_DISTANCE, 0, maxSpeed);
      desired.limit(speed);
    } else {
      desired.limit(maxSpeed);
    }

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxAcceleration);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void display() {
    float theta = velocity.heading() + PI/2;


    pushMatrix();
    translate(location.x, location.y);

    stroke(0);
    strokeWeight(2);
    fill(240);
    rotate(theta);
    beginShape();
    vertex(0, -size*2);
    vertex(-size, size*2);
    vertex(size, size*2);
    endShape(CLOSE);
    popMatrix();
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
  
  PVector getVelocity() {
    return velocity.copy();
  }

  PVector getLocation() {
    return location.copy();
  }
}