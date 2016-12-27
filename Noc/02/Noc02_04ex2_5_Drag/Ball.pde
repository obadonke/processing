// Based on code samples in Nature of Code by Daniel Shiffman

class Ball extends Mover {
  Random generator;
  final float BallMassMean = 5;
  final float BallMassStdDeviation = 0.6;
  int xStart;
  
  Ball(Random generator, int x) {
    super();
    this.xStart = x;
    this.generator = generator;
    reset();
  }

  void reset() {    
    velocity = new PVector(0, 0);
    location = new PVector(xStart, random(30,200));
    mass = BallMassMean + (float)(generator.nextGaussian()*BallMassStdDeviation);
  }

  void update() {
    applyForces();
    super.update();
    checkEdges();
  }

  void applyForces() {
    // gravity is proportional to mass
    PVector gravity = new PVector(0, 0.05*mass);
    applyForce(gravity);
  }
  
  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = height;
    }
  }
}