// Nature of Code - page 58-59
// Modified example of acceleration towards the mouse
// The Movers will lose interest in the mouse if the mouse is stationary for too many frames.
// The amount of time before a Mover loses interest is randomised using a Gaussian so that
// the majority of Movers will lose interest after about 300 frames.

class Vehicle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float maxAcceleration;
  float size = 3;

  PVector wanderCenter;
  PVector futureLocation;

  Vehicle(float x, float y, float r) {
    size = r;
    location = new PVector(x, y);
    velocity = PVector.random2D();
    maxSpeed = MAX_SPEED;
    maxAcceleration = MAX_ACCELERATION;
    acceleration = new PVector(0, 0);
  }

  void update() {
    acceleration.limit(maxAcceleration);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void wander() {
    // choose a new target based on current velocity
    wanderCenter = velocity.copy();
    wanderCenter.normalize();
    wanderCenter.mult(WANDER_ARM_LENGTH);
    float theta = random(TWO_PI);
    futureLocation = new PVector(sin(theta), cos(theta));
    futureLocation.mult(WANDER_RADIUS);
    futureLocation.add(wanderCenter);
    seek(PVector.add(location, futureLocation));
  }
  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);

    float dist = desired.mag();
    if (dist < APPROACH_DISTANCE) {
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

    if (DRAW_WANDER_DIAG) {
      stroke(200);
      strokeWeight(1);
      noFill();
      ellipseMode(CENTER);
      ellipse(wanderCenter.x, wanderCenter.y, WANDER_RADIUS*2, WANDER_RADIUS*2);
      line(0,0, wanderCenter.x, wanderCenter.y);
      line(wanderCenter.x, wanderCenter.y, futureLocation.x, futureLocation.y);
    }

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
}