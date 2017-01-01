class Pendulum {
  float r;
  Spring s;
  Pin bob;
  float angle;
  float angularVel;
  float angularAcc;
  PVector GravityForce = new PVector(0, 1);
  float len;
  int bobSize;
  
  Pendulum(int x, int y, float len, float startAngle) {
    angle = startAngle;
    bob = new Pin(x+1.1*len*sin(angle), y+1.1*len*cos(angle));
    s = new Spring(x, y, len, (IPin)bob);
  }
  
  void update() {
    s.applyForces();
    bob.update();
  }
  
  void display() {
    
    bob.applyForce(GravityForce);
    bob.update();

    s.display();
    bob.display();
  }
}