class Spring {
  PVector anchor;
  float restingLength;
  float kFactor = 0.2;
  IPin pinB;
  final float NumCoils = 20;
  final float CoilWidth = 2;
  
  Spring(float x, float y, float l, IPin b) {
    anchor = new PVector(x,y);
    restingLength = l;
    pinB = b;
  }
  
  void display() {
    fill(100);
    rectMode(CENTER);
    rect(anchor.x, anchor.y, 10, 10);
    
    displaySpring();
  }
  
  void applyForces() {
    PVector force = PVector.sub(pinB.getLocation(), anchor);
    float len = force.mag();
    float stretch = len-restingLength;
    force.normalize();
    force.mult(-1 * kFactor * stretch);
    pinB.applyForce(force);
  }
  
  void displaySpring() {
    stroke(0);
    PVector dirToPinB = PVector.sub(pinB.getLocation(), anchor);
    float len = dirToPinB.mag();
    float segmentLen = len/NumCoils;
    float subSegLen = segmentLen/4.0;
    pushMatrix();
    translate(anchor.x, anchor.y);
    rotate(dirToPinB.heading()-HALF_PI);
    float coilStart = 0;
    while (coilStart < len-1) {
      line(0, coilStart, CoilWidth, coilStart+subSegLen);
      line(CoilWidth, coilStart+subSegLen, -CoilWidth, coilStart+3*subSegLen);
      line(-CoilWidth, coilStart+3*subSegLen, 0, coilStart+segmentLen);
      coilStart += segmentLen;
    }
    popMatrix();
  }
}