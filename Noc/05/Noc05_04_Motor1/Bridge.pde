// Riffing off example in Nature of Code by Daniel Shiffman. Exercise 5.6

class Bridge {
  float bridgeHeight;
  float stepRadius;
  ArrayList<Body> steps;
  float restLength;

  Bridge(float h, float stepRadius, float slackFactor) {
    this.bridgeHeight = h;
    this.stepRadius = stepRadius;
    this.restLength = slackFactor;
    steps = new ArrayList<Body>();
    buildBridge();
  }

  void buildBridge() {
    float totalLinks = (int)(width/(stepRadius*2));
    if (totalLinks < 2) {
      println("Woops! There won't be enough steps to build a bridge.");
      return;
    }

    float xDelta = width/totalLinks;
    println("xDelta = " + xDelta);
    float x = stepRadius;
    int linksCreated = 0;

    Body prevBody = createStep(0, bridgeHeight, true); //<>//

    while (linksCreated < totalLinks) {
      Body curBody = createStep(x, bridgeHeight, false);
      linkSteps(prevBody, curBody);

      prevBody = curBody;
      x += xDelta;
      linksCreated += 1;
    }

    Body finalBody = createStep(width, bridgeHeight, true);

    linkSteps(prevBody, finalBody);
  }

  private Body createStep(float x, float y, boolean isStatic) {   
    BodyDef bd = new BodyDef();      
    bd.type = isStatic ? BodyType.STATIC : BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    Body body = box2d.createBody(bd);

    CircleShape sd = new CircleShape();
    sd.setRadius(box2d.scalarPixelsToWorld(stepRadius));

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;

    fd.density = 2;
    fd.friction = 0.2;
    fd.restitution = 0.0;

    body.createFixture(fd);
    steps.add(body);
    
    return body;
  }

  private void linkSteps(Body stepL, Body stepR) {
    DistanceJointDef djd = new DistanceJointDef();
    djd.bodyA = stepL;
    djd.bodyB = stepR;
    djd.length = box2d.scalarPixelsToWorld(restLength);
    djd.frequencyHz = 8;
    djd.dampingRatio = 0.5;

    box2d.world.createJoint(djd);
  }

  void display() {
    for (Body step : steps) {
      Vec2 pos = box2d.getBodyPixelCoord(step);

      float a = step.getAngle();

      pushMatrix();
      translate(pos.x, pos.y);    // Using the Vec2 position and float angle to
      ellipse(0, 0, stepRadius*2, stepRadius*2);
      rotate(-a);          
      fill(175);
      stroke(0);
      line(0, 0, stepRadius, 0);
      popMatrix();
    }
  }
}