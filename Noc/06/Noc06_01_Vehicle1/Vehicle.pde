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
  PVector oldTarget;
  float maxAcceleration;
  
  Vehicle() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    maxSpeed = 2;
    maxAcceleration = 0.4;
    acceleration = new PVector(0, 0);
    oldTarget = new PVector(0, 0);
  }

  void update() {
    PVector newTarget = new PVector(mouseX, mouseY);
    boolean sameTarget = (newTarget.x == oldTarget.x  && newTarget.y == oldTarget.y);

    PVector dir = PVector.sub(newTarget, location);

    dir.normalize();
    acceleration = dir.mult(maxAcceleration);
    oldTarget = newTarget;

    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
  }

  void display() {
    stroke(0);
    strokeWeight(2);

    fill(240);
    ellipse(location.x, location.y, 24, 24);
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