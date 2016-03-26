// Nature of Code - Exercise 2.3 - Page 77

class Ball extends Mover {
  float dragFactor = 0.01;
  final float CoefficientOfRestitution = 1;
  Random generator;
  
  Ball(Random generator) {
    super();
    this.generator = generator;
    
    reset();
  }

  void reset() {    
    velocity = new PVector(0, 0);
    location = new PVector(random(0, width), random(30,60));
    mass = 1.5f + (float)(generator.nextGaussian()*0.4);
  }

  void update() {
    applyForces();
    super.update();
    checkEdges();
  }

  void applyForces() {
    PVector wind = new PVector(0.01, 0);
    applyForce(wind);

    // gravity is proportional to mass
    PVector gravity = new PVector(0, 0.1*mass);
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
}