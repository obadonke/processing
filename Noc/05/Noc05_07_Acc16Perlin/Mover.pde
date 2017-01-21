// Nature of Code - page 54

class Mover {
  Body body;
  PVector location;
  float noiseOffset;
  final float radius = 14;
  float maxAcceleration;
  float maxSpeed;
  Vec2 curForce = null;
  
  Mover() {
    location = new PVector(randomDim(width), randomDim(height));
    noiseOffset = random(3000);
    
    createBody();
    maxAcceleration = body.getMass()*2;
    maxSpeed = box2d.scalarPixelsToWorld(100);
  }

  float randomDim(float max) {
    return 0.1*max+random(max*0.8);
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
    fd.density = 2;
    fd.friction = 0.0;
    fd.restitution = 0.0;
    
    body.createFixture(fd);
    body.setBullet(true);
  }

  void update() {
    curForce = chooseForce();  
    body.applyForceToCenter(curForce);
    
    
    noiseOffset+=0.0001;

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
    force.x = chooseAccComponent(location.x, width, 0);
    force.y = -chooseAccComponent(location.y, height, 1000);
    force = force.mul(body.getMass());

    return force;
  }

  float chooseAccComponent(float currentVal, float max, float noiseShift) {
    if (currentVal > max*0.9) {
      return -maxAcceleration;
    } else if (currentVal < max*0.1) {
      return maxAcceleration;
    }
     
   return noise2scalar(noiseOffset+noiseShift);
  }

  float noise2scalar(float offset) {
    return map(noise(offset), 0, 1, -maxAcceleration, maxAcceleration);
  }
}