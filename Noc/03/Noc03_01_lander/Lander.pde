// the lander spacecraft

class Lander extends Mover {
  PVector heading;
  final int ShipWidth = 40;
  final int ShipHeight = 60;
  final int ThrusterHeight = 5;
  final int ThrusterWidth = 5;
  final int ThrusterInset = 3;
  boolean leftThrustOn = false;
  boolean rightThrustOn = false;
  
  Lander(PVector startLoc) {
    super();
    location = startLoc.copy();
    heading = new PVector(1,0);
  }
  
  void draw() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(heading.heading()-HALF_PI);
   
    drawThruster(ThrusterInset-ShipWidth/2, rightThrustOn, false);
    drawThruster(ShipWidth/2-ThrusterInset-ThrusterWidth, leftThrustOn, true);
    drawBody();
    popMatrix();
  }
  
  void update() {
    super.update();
  }
  
  void drawThruster(int offsetFromCenter, boolean drawThrust, boolean reversed) {
    fill(200,0,0);
    stroke(0);
    int firstY = reversed ? 2 : 0;
    beginShape();
    vertex(offsetFromCenter, firstY);
    vertex(offsetFromCenter, ThrusterHeight);
    vertex(offsetFromCenter+ThrusterWidth, ThrusterHeight);
    vertex(offsetFromCenter+ThrusterWidth, 2-firstY);
    endShape();
    
    if (drawThrust) {
      int thrustApexX = offsetFromCenter+ThrusterWidth/2;
      fill(0,240,200);
      noStroke();
      beginShape();
      vertex(thrustApexX, -1);
      vertex(thrustApexX-2, -ThrusterHeight);
      vertex(thrustApexX, -2*ThrusterHeight);
      vertex(thrustApexX+2, -ThrusterHeight);
      endShape();
    }
  }
  
  void drawBody() {
    stroke(0);
    fill(0,100,200);
    triangle(-ShipWidth/2,ThrusterHeight,0,ShipHeight-ThrusterHeight,ShipWidth/2,ThrusterHeight);
  }
  
  void leftThrust(boolean on) {
    leftThrustOn = on;
  }
  
  void rightThrust(boolean on) {
    rightThrustOn = on;
  }
}