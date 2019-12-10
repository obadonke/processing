// Nature of Code - Exercise 2.1 - Page 70
class Balloon extends Mover {
  PVector heliumForce = new PVector(0, -random(0.01, 0.05));
  float dragFactor = 0.01;
  int collisions;
  final int MaxCollisions = 100;
  final float CoefficientOfRestitution = 0.8;

  Balloon() {
    super();

    reset();
  }

  void reset() {    
    // start somewhere along bottom row of screen
    velocity = new PVector(0, 0);
    location = new PVector(random(0, width), height);
    collisions = 0;
  }

  void update() {
    applyForce(heliumForce);
    applyDrag();
    super.update();
  }

  void applyDrag() {
    PVector drag = PVector.mult(velocity, -dragFactor);
    applyForce(drag);
  }

  void collisionDetected() {
    collisions++;

    if (collisions > MaxCollisions) {
      reset();
    }
  }

  void bounceOffCeiling(int ceilingHeight) {
    location.y = ceilingHeight+radius;
    PVector reaction = new PVector(0, -velocity.y*(1+CoefficientOfRestitution));
    applyForce(reaction);
    
    collisionDetected();
  }
}