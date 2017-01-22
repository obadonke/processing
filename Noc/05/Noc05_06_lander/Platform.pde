// attempt at defining a static ground body

class Platform {
  Body body;
  float x, y;
  float floorHeight;
  float floorWidth;
  
  Platform(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    floorHeight = h;
    floorWidth = w;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.setPosition(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    
    PolygonShape shape = new PolygonShape();
    float platformW = box2d.scalarPixelsToWorld(floorWidth/2);
    float platformH = box2d.scalarPixelsToWorld(floorHeight/2);
    shape.setAsBox(platformW, platformH);
    
    FixtureDef fixDef = new FixtureDef();
    fixDef.shape = shape;
    fixDef.restitution = 0.3;
    fixDef.friction = 0.5;
    body.createFixture(fixDef);
  }
  
    void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    
    pushMatrix();
    translate(pos.x,pos.y);    // Using the Vec2 position and float angle to
    //rotate(-a);              // translate and rotate the rectangle
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,floorWidth,floorHeight);
    popMatrix();
  }

}