// Nature of Code - Exercise 2.3 - Page 77
// Ball is repelled from the wall.
class Ball extends Mover {
  float dragFactor = 0.01;
  final float CoefficientOfRestitution = 1;
  Random generator;
  final float MaxWallRepulsionForce = 0.5;
  final float MaxMouseRepulsionForce = 2;
  final float RepulsionExponent = 3;
  final float BallMassMean = 3;
  final float BallMassStdDeviation = 0.6;
  
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
    mass = BallMassMean + (float)(generator.nextGaussian()*BallMassStdDeviation);
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
    
    if (mousePressed) {
      applyMouseRepulsion();
    }
  }

  void applyWallRepulsion() {
    float wallLocation;
    PVector direction;
    
    if (location.x < RepulsionRange) {
      wallLocation = 0;
      direction = new PVector(1.0,0);
    } else {
      wallLocation = width;
      direction = new PVector(-1.0,0);
    }
       
    applyRepulsionBasedOnDistance(abs(location.x - wallLocation), direction, MaxWallRepulsionForce);
  }
  
  void applyMouseRepulsion() {
    PVector direction;
    
    float distanceFromMouse = abs(location.x - mouseX);
    if (distanceFromMouse < 0.001) {
      direction = new PVector(1.0,0);  // go right if in doubt
    } else if (location.x < mouseX) {
      direction = new PVector(-1,0);
    } else {
      direction = new PVector(1.0,0);
    }
    
    applyRepulsionBasedOnDistance(distanceFromMouse,direction,MaxMouseRepulsionForce);
    
  }
     
  void applyRepulsionBasedOnDistance(float distance, PVector direction, float maxForce) {
    if (distance >= RepulsionRange) return;
    
    float magnitude = pow((RepulsionRange-distance)/RepulsionRange,RepulsionExponent)*maxForce;
    if (magnitude > 0.001) applyForce(PVector.mult(direction,magnitude));  
  }
  
  void checkEdges() {
    if (location.x > width) {
      location.x = width-5;
      velocity.x = -CoefficientOfRestitution*abs(velocity.x);
    } else if (location.x < 0) {
      location.x = 5;
      velocity.x = CoefficientOfRestitution*abs(velocity.x);
    }
    
    if (location.y > height) {
      location.y = height;
      velocity.y *= -CoefficientOfRestitution;
    }
  }
}