class Pendulum {
  float r;
  float angle;
  float angularVel;
  float angularAcc;
  final float Gravity = 0.4;
  PVector pivotLocation;
  float len;
  int bobSize;
  
  Pendulum(int x, int y, float len, float startAngle, int bobSize) {
    pivotLocation = new PVector(x, y);
    angle = startAngle;
    this.len = len;
    this.bobSize = bobSize;
  }
  
  void update() {
    angularAcc = -1*Gravity*sin(angle)/len;
    angularVel += angularAcc;
    angle += angularVel;
    
    angularVel *= 0.997;
  }
  
  void display() {
    pushMatrix();
    
    translate(pivotLocation.x, pivotLocation.y);
    
    PVector bobLocation = new PVector(len*sin(angle), len*cos(angle));
    line(0,0, bobLocation.x, bobLocation.y);
    fill(0,200,0);
    ellipse(bobLocation.x, bobLocation.y, bobSize, bobSize);
    
    popMatrix();
  }
}