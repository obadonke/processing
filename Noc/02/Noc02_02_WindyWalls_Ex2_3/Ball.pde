// Nature of Code - Exercise 2.3 - Page 77
// Ball is repelled from the wall.
class Ball extends Mover {
  float dragFactor = 0.01;
  final float CoefficientOfRestitution = 1;
  Random generator;
  final float MaxRepulsionForce = 0.5;
  final float RepulsionExponent = 3;
  final PVector WindForce = new PVector(0.01,0);
  
  int repulsionRange;
  
  Ball(Random generator, int repulsionRange) {
    super();
    this.generator = generator;
    this.repulsionRange = repulsionRange;
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
    applyForce(WindForce);

    // gravity is proportional to mass
    PVector gravity = new PVector(0, 0.1*mass);
    applyForce(gravity);
    
    applyWallRepulsion();
  }

  void applyWallRepulsion() {
    float distanceFromWall = location.x;
    float repulsionSign = 1;
    
    if (location.x > RepulsionRange) {
      distanceFromWall = width-location.x;
      repulsionSign = -1;
    }
    
    if (distanceFromWall >= RepulsionRange) return;
    
    float magnitude = pow((RepulsionRange-distanceFromWall)/RepulsionRange,RepulsionExponent)*MaxRepulsionForce*repulsionSign;
    applyForce(new PVector(magnitude,0));  
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