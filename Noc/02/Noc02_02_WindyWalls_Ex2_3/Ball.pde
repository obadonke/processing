// Nature of Code - Exercise 2.3 - Page 77

class Ball extends Mover {
  PVector heliumForce = new PVector(0, -random(0.01, 0.05));
  float dragFactor = 0.01;
  int collisions;
  final int MaxCollisions = 100;
  final float CoefficientOfRestitution = 1;

  Ball() {
    super();

    reset();
  }

  void reset() {    
    // start somewhere along bottom row of screen
    velocity = new PVector(0, 0);
    location = new PVector(random(0, width), random(30,60));
    collisions = 0;
    mass = random(1,2);
  }

  void update() {
    applyForces();
    super.update();
  }

  void applyForces() {
    PVector wind = new PVector(0.01, 0);
    applyForce(wind);

    PVector gravity = new PVector(0, 0.1);
    applyForce(gravity);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -CoefficientOfRestitution;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -CoefficientOfRestitution;
    }
    
    if (location.y > height) {
      location.y = height;
      velocity.y *= -CoefficientOfRestitution;
    }
  }

  void collisionDetected() {
    collisions++;

    if (collisions > MaxCollisions) {
      reset();
    }
  }
}