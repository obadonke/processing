// A rectangular box - taken directly from Shiffman examples

static int BoxId = 0;

class Box implements IBox, IContactable {
  //  Instead of any of the usual variables, we will store a reference to a Box2D Body
  Body body;      

  float w, h;
  int id;
  color c;
  boolean markedForDeletion;

  Box(float x, float y) {
    this(x, y, 16, 16, color(128));
  }

  Box(float x, float y, float w, float h, color c) {
    this.w = w;
    this.h = h;
    this.c = c;
    id = ++BoxId;
    markedForDeletion = false;

    createBox2dBody(x, y);
  }

  void display() {
    if (isDead()) return;

    if (markedForDeletion) {
      kill();
      return;
    }

    // We need the Body’s location and angle
    Vec2 pos = box2d.getBodyPixelCoord(body);

    if (pos.y > height+h)
    {
      kill();
      return;
    }

    float a = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);              // translate and rotate the rectangle
    fill(c);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }

  Body getBody() {
    return body;
  }

  void kill() {
    if (isDead()) return;

    box2d.destroyBody(body);
    print("[RIP"+id+"]");
    body = null;
  }

  boolean isDead() {
    return body == null;
  }

  boolean contains(float x, float y) {
    if (isDead()) return false;

    // we will ignore rotation and ignore tolerance issues
    Vec2 pos = box2d.getBodyPixelCoord(body);
    Vec2 delta = new Vec2(x, y);
    delta = delta.sub(pos).abs();
    return (abs(delta.x) < w/2.0 && abs(delta.y) < h/2.0);
  }

  void createBox2dBody(float x, float y) {
    // Build Body
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);


    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);  // Box2D considers the width and height of a
    sd.setAsBox(box2dW, box2dH);            // rectangle to be the distance from the
    // center to the edge (so half of what we
    // normally think of as width or height.) 
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 2;
    fd.friction = 0.3;
    fd.restitution = 0.6;

    // Attach Fixture to Body               
    body.createFixture(fd);
    body.applyAngularImpulse(body.getMass()*random(3, 5));
    body.setUserData(this);
  }
  
  // IContactable
  void madeContact(IContactable other) {
    println("Box [" + id + "] I've been hit!");
    if (other == null) return;

    switch (other.getContactRole()) {
    case Missile:
      ploppSound.play();
      markedForDeletion = true;
      break;
    default:
      break;
    }
  }

  ContactRole getContactRole() {
    return ContactRole.Target;
  }
}