// Based on code samples in Nature of Code by Daniel Shiffman

class Ball extends Mover {
  Random generator;
  final float BallMassMean = 3;
  final float BallMassStdDeviation = 1;
  int xStart;
  int yMax;
  
  Ball(Random generator, int x, int yMax) {
    super();
    this.xStart = x;
    this.yMax = yMax;
    this.generator = generator;
    reset();
  }

  void reset() {    
    velocity = new PVector(0, 0);
    location = new PVector(xStart, random(0, yMax));
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