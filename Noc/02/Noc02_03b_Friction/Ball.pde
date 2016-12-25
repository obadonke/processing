// Modified from Noc02_03_Friction1
// A ball wants to travel in a target direction at a constant speed.
// Friction is an outside force that gets in the way (it will be applied by the main loop)
// Each ball has a maximum acceleration which affects how quickly it can achieve its target.

class Ball extends Mover {
  Random generator;
  final float GravityCoefficient = 0.1;
  final float BallMassMean = 3;
  final float BallMassStdDeviation = 0.6;
  PVector targetVelocity;
  final float maxAcceleration = 0.1;
  float noiseOffset;
  
  Ball(Random generator) {
    super();
    this.generator = generator;
    reset();
  }

  void reset() {    
    velocity = new PVector(0, 0);
    location = new PVector(random(0, width), random(0,height));
    mass = BallMassMean + (float)(generator.nextGaussian()*BallMassStdDeviation);
    noiseOffset = random(0,10000);
    setTargetVelocity();
  }

  void update() {
    applyForces();
    super.update();
    traverseEdges();
    noiseOffset += 0.01;
  }

  void applyForces() {
    PVector velocityAdjustment = PVector.sub(targetVelocity, velocity);
    
    if (velocityAdjustment.mag() < 0.1) {
      // choose another target
      setTargetVelocity();
    } else {
      velocityAdjustment.setMag(maxAcceleration);
      applyForce(velocityAdjustment);
    }
  }

  float getWeight() {
    return  GravityCoefficient * mass;
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
  
  void setTargetVelocity() {
    float x = map(noise(noiseOffset),0,1,-1,1);
    float y = map(noise(noiseOffset+1000),0,1,-1,1);
    PVector v = new PVector(x, y);
    v.normalize();
    v.setMag(random(2,4));
    targetVelocity = v;
  }

}