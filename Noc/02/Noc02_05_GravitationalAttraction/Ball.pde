
class Ball extends Mover {
  Random generator;
  final float BallMassMean = 60;
  final float BallMassStdDeviation = 30;
  
  Ball(int x, int y, float m) {
    super();
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    mass = m;
  }

  void update() {
     super.update();
    //traverseEdges();
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