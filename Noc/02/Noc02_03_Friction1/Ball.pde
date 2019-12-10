// Based on code samples in Nature of Code by Daniel Shiffman

class Ball extends Mover {
  float dragFactor = 0.01;
  final float CoefficientOfRestitution = 1;
  Random generator;
  final float MaxWallRepulsionForce = 0.5;
  final float MaxMouseRepulsionForce = 2;
  final float RepulsionExponent = 3;
  final float BallMassMean = 3;
  final float BallMassStdDeviation = 0.6;
  
  final PVector WindForce = new PVector(0.02,0);
  
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
  }

  void applyFriction(float coefficient) {
    if (abs(coefficient) < 0.001) return;
    
    PVector friction = velocity.copy();
    // For now we're assuming friction applies in every direction equally.
    friction.mult(-1);
    friction.normalize();
    friction.mult(coefficient);
    
    applyForce(friction);
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
     
  void applyRepulsionBasedOnDistance(float distance, PVector direction, float maxForce) {
    if (distance >= RepulsionRange) return;
    
    float magnitude = pow((RepulsionRange-distance)/RepulsionRange,RepulsionExponent)*maxForce;
    if (magnitude > 0.001) applyForce(PVector.mult(direction,magnitude));  
  }
  
  void checkEdges() {
    if (location.x > width) {
      location.x = width-1;
      velocity.x = -CoefficientOfRestitution*abs(velocity.x);
    } else if (location.x < 0) {
      location.x = 1;
      velocity.x = CoefficientOfRestitution*abs(velocity.x);
    }
    
    if (location.y > height) {
      location.y = height;
      if (abs(velocity.y) > 0.01) {
        velocity.y *= -CoefficientOfRestitution;
      }
      else {
        velocity.y = 0;
      }
    }
  }
}