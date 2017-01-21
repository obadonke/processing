// the spacecraft

class Lander {
  Body body;
  final int ShipHalfWidth = 20;
  final int ShipHeight = 60;
  final int ThrusterHeight = 5;
  final int ThrusterWidth = 8;
  final int ThrusterInset = 3;
  final int ThrusterVertStep = 2;
  
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

    drawBody();
    pushMatrix();
    translate(ThrusterInset-ShipHalfWidth, 0);
    drawThruster(rightThrustOn, false);
    popMatrix();
    pushMatrix();
    translate(ShipHalfWidth-ThrusterInset-ThrusterWidth, 0);
    drawThruster(leftThrustOn, true);
    popMatrix();
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

  void drawThruster(boolean drawThrust, boolean left) {
    fill(200, 0, 0);
    stroke(0);
    float curOffset = left ? 0 : ThrusterVertStep;
    beginShape();
    vertex(0, ThrusterHeight-curOffset);
    vertex(0, 0);
    vertex(ThrusterWidth, 0);
    curOffset = 2-curOffset;
    vertex(ThrusterWidth, ThrusterHeight-curOffset);
    endShape();

    if (drawThrust) {
      int thrustApexX = ThrusterWidth/2;
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

    createShipBody();
    createThruster(true);
    createThruster(false);

    body.setAngularVelocity(0.2);
  }

  void createShipBody() {
    PolygonShape bodyShape = new PolygonShape();

    Vec2[] points = new Vec2[3];
    points[0] = new Vec2(box2d.scalarPixelsToWorld(ShipHalfWidth), 0);
    points[1] = new Vec2(0, box2d.scalarPixelsToWorld(ShipHeight));
    points[2] = new Vec2(box2d.scalarPixelsToWorld(-ShipHalfWidth), 0);
    bodyShape.set(points, 3);
    if (!bodyShape.validate()) {
      println("Body shape is not valid.");
    }

    addFixtureToBody(bodyShape);
  }

  void createThruster(boolean left) {
    PolygonShape shape = new PolygonShape();

    float thrusterHeight = box2d.scalarPixelsToWorld(ThrusterHeight);
    float thrusterVertOffset = box2d.scalarPixelsToWorld(ThrusterVertStep);
    float curOffset = left ? thrusterVertOffset : 0;
    float thrusterWidth = box2d.scalarPixelsToWorld(ThrusterWidth);
    
    float offsetFromShipCenterToLeftEdge = left ? ThrusterInset-ShipHalfWidth : ShipHalfWidth-ThrusterInset-ThrusterWidth;
    offsetFromShipCenterToLeftEdge = box2d.scalarPixelsToWorld(offsetFromShipCenterToLeftEdge);
    
    Vec2[] points = new Vec2[4];
    points[0] = new Vec2(offsetFromShipCenterToLeftEdge, -thrusterHeight+curOffset);
    points[1] = new Vec2(offsetFromShipCenterToLeftEdge, 0);
    points[2] = new Vec2(offsetFromShipCenterToLeftEdge+thrusterWidth, 0);
    
    curOffset = thrusterVertOffset-curOffset;
    points[3] = new Vec2(offsetFromShipCenterToLeftEdge+thrusterWidth, -thrusterHeight+curOffset);

    shape.set(points, 4);
    if (!shape.validate()) {
      println("Body shape is not valid.");
    }
    addFixtureToBody(shape);
  }

  void addFixtureToBody(PolygonShape shape) {
    FixtureDef fd = new FixtureDef();
    fd.shape = shape;
    fd.density = 2;
    fd.friction = 0;
    fd.restitution = 0.2;

    body.createFixture(fd);
  }
}