// Modified from Noc02_03_Friction1

class Ball extends Mover {
  float dragFactor = 0.01;
  Random generator;
  final float MaxMouseRepulsionForce = 2;
  final float RepulsionExponent = 3;
  final float BallMassMean = 3;
  final float BallMassStdDeviation = 0.6;
  
  final PVector WindForce = new PVector(0.02,0);
  final float basicFrictionCoefficient = 0.5;
  
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
    traverseEdges();
  }

  void applyForces() {
    applyForce(WindForce);
    
    // gravity is proportional to mass
    PVector gravity = new PVector(0, 0.1*mass);
    applyForce(gravity);
    
    applyFriction(basicFrictionCoefficient);
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
       
  void applyRepulsionBasedOnDistance(float distance, PVector direction, float maxForce) {
    if (distance >= RepulsionRange) return;
    
    float magnitude = pow((RepulsionRange-distance)/RepulsionRange,RepulsionExponent)*maxForce;
    if (magnitude > 0.001) applyForce(PVector.mult(direction,magnitude));  
  }
  
  void traverseEdges() {
    if (location.x > width) {
      location.x = 1;
    } else if (location.x < 0) {
      location.x = width-1;
    }
    
    if (location.y > height) {
      location.y = 1;
    } else if (location.y < 0) {
      location.y = height-1;
    }
  }
}