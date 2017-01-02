// attempt at defining a static ground body

class Ground {
  Body body;
  float floorHeight;
  float floorWidth;
  
  Ground(float w, float h) {
    floorHeight = h;
    floorWidth = w;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.setPosition(box2d.coordPixelsToWorld(width/2,floorHeight));
    body = box2d.createBody(bd);
    
    PolygonShape shape = new PolygonShape();
    float groundW = box2d.scalarPixelsToWorld(floorWidth/2);
    float groundH = box2d.scalarPixelsToWorld(5);
    shape.setAsBox(groundW, groundH);
    
    FixtureDef fixDef = new FixtureDef();
    fixDef.shape = shape;
    fixDef.restitution = 0.8;

    body.createFixture(fixDef);
  }
  
    void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    float a = body.getAngle();

    pushMatrix();
    translate(pos.x,pos.y);    // Using the Vec2 position and float angle to
    //rotate(-a);              // translate and rotate the rectangle
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,floorWidth,5);
    popMatrix();
  }

}