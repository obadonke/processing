// the lander spacecraft

class Lander {
  PVector location;
  PVector direction;
  final int ShipWidth = 80;
  final int ShipHeight = 120;
  final int ThrusterHeight = 10;
  final int ThrusterWidth = 10;
  final int ThrusterInset = 5;
  
  Lander(PVector startLoc) {
    location = startLoc.copy();
    direction = new PVector(0,-1);
  }
  
  void draw() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(direction.heading()-HALF_PI);
    
    drawThruster(ThrusterInset-ShipWidth/2);
    drawThruster(ShipWidth/2-ThrusterInset-ThrusterWidth);
    drawBody();
    popMatrix();
  }
  
  void drawThruster(int offsetFromCenter) {
    fill(200,0,0);
    rect(offsetFromCenter, 0, ThrusterWidth, ThrusterHeight);
  }
  
  void drawBody() {
    fill(0,100,200);
    triangle(-ShipWidth/2,ThrusterHeight,0,ShipHeight-ThrusterHeight,ShipWidth/2,ThrusterHeight);
  }
  
  Rect getBoundingBox() {
    // TODO: rotated?
    return new Rect(location.x-ShipWidth/2, location.y, ShipWidth, ShipHeight); 
  }
}