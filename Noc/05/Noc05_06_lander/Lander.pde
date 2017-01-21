// the spacecraft

class Lander {
  Body body;
  final int ShipHalfWidth = 20;
  final int ShipHeight = 60;
  final int ThrusterHeight = 5;
  final int ThrusterWidth = 5;
  final int ThrusterInset = 3;
  boolean leftThrustOn = false;
  boolean rightThrustOn = false;
  final float thrustForceMag = 4;

  Lander(PVector startLoc) {
    super();
    
    createBody(startLoc);
  }

  void draw() {
    PVector location = box2d.coordWorldToPixelsPVector(body.getPosition());
    float angle = body.getAngle();
    pushMatrix();
    translate(location.x, location.y);
    rotate(-angle);

    //drawThruster(ThrusterInset-ShipHalfWidth, rightThrustOn, false);
    //drawThruster(ShipHalfWidth-ThrusterInset-ThrusterWidth, leftThrustOn, true);
    drawBody();
    popMatrix();
  }

  void update() {
    float angle = 0;
    PVector thrustForceVector = PVector.fromAngle(angle);
    if (leftThrustOn) {
      thrustForceVector.setMag(thrustForceMag);
      //body.applyForce(thrustForceVector);
   }

    if (rightThrustOn) {
      thrustForceVector.setMag(thrustForceMag);
      //body.applyForce(thrustForceVector);
    }
  }

  void drawThruster(int offsetFromCenter, boolean drawThrust, boolean reversed) {
    fill(200, 0, 0);
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
      fill(0, 240, 200);
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
    fill(0, 100, 200);
        
    triangle(-ShipHalfWidth, 0, 0, -ShipHeight, ShipHalfWidth, 0);
  }

  void leftThrust(boolean on) {
    leftThrustOn = on;
  }

  void rightThrust(boolean on) {
    rightThrustOn = on;
  }
  
  void createBody(PVector location) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(location));
    body = box2d.createBody(bd);
    
    // main ship body
    PolygonShape bodyShape = new PolygonShape();
    //bodyShape.setAsBox(box2d.scalarPixelsToWorld(ShipHalfWidth),box2d.scalarPixelsToWorld(ShipHeight));
    
    Vec2[] points = new Vec2[3];
    points[0] = new Vec2(box2d.scalarPixelsToWorld(ShipHalfWidth),0);
    points[1] = new Vec2(0, box2d.scalarPixelsToWorld(ShipHeight));
    points[2] = new Vec2(box2d.scalarPixelsToWorld(-ShipHalfWidth),0);
    bodyShape.set(points,3);
    if (!bodyShape.validate()) {
      println("Body shape is not valid.");
    }
    
    println(bodyShape.getVertex(0));
    println(bodyShape.getVertex(1));
    println(bodyShape.getVertex(2));
    
    
    FixtureDef fd = new FixtureDef();
    fd.shape = bodyShape;
    fd.density = 2;
    fd.friction = 0;
    fd.restitution = 0.2;
    
    body.createFixture(fd);
    body.setAngularVelocity(0.2);
  }
  
}