// Nature of Code - page 54

class Mover {
  Body body;
  PVector location;
  float noiseOffset;
  float radius;
  float maxAcceleration;
  float maxSpeed;
  Vec2 curForce = null;
  
  Mover() {
    radius = random(8,22);
    location = new PVector(randomDim(width), randomDim(height));
    noiseOffset = random(3000);
    
    createBody();
    maxAcceleration = body.getMass()*box2d.scalarPixelsToWorld(20);
    maxSpeed = box2d.scalarPixelsToWorld(100);
  }

  float randomDim(float max) {
    return 0.05*max+random(max*0.9);
  }
  
  void createBody() {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(location.x, location.y));
    body = box2d.createBody(bd);
    
    // define fixture
    CircleShape cs = new CircleShape();
    cs.setRadius(box2d.scalarPixelsToWorld(radius));
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 10;
    fd.friction = 0.0;
    fd.restitution = 0.8;
    
    body.createFixture(fd);
    body.setBullet(true);
  }

  void update() {
    curForce = chooseForce();  
    body.applyForceToCenter(curForce);
    
   
    Vec2 velocity = body.getLinearVelocity();
    float speed = velocity.length();
    if (speed > maxSpeed)
      body.setLinearVelocity(velocity.mul(maxSpeed / speed));
  }

  void display() {
    location = box2d.coordWorldToPixelsPVector(body.getPosition());
    
    stroke(0);
    strokeWeight(2);
    fill(240);
    ellipse(location.x, location.y, radius*2, radius*2);
  }

  Vec2 chooseForce() {
    location = box2d.coordWorldToPixelsPVector(body.getPosition());

    Vec2 force = new Vec2();
    boolean onlyCorrection = random(1) < 0.99;
    force.x = chooseAccComponent(location.x, width, 0, onlyCorrection);
    force.y = -chooseAccComponent(location.y, height, 1000, onlyCorrection);
    
    force = force.mul(body.getMass());
    if (curForce != null) {
      if (force.x == 0.0) force.x = curForce.x;
      if (force.y == 0.0) force.y = curForce.y;
    }
    return force;
  }

  float chooseAccComponent(float currentVal, float max, float noiseShift, boolean onlyCorrection) {
    if (currentVal > max*0.95) {
      return -maxAcceleration*0.7;
    } else if (currentVal < max*0.05) {
      return maxAcceleration*0.7;
    }
     
   return onlyCorrection ? 0 : noise2scalar(noiseOffset+noiseShift);
  }

  float noise2scalar(float offset) {
    noiseOffset+=0.01;
    return map(noise(offset), 0, 1, -maxAcceleration, maxAcceleration);
  }
}