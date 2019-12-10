// Based on The Nature of Code by Daniel Shiffman
// http://natureofcode.com

// An uneven surface boundary

class Surface {
  ArrayList<Vec2> surface;

  Surface() {
    surface = new ArrayList<Vec2>();

    ChainShape chain = new ChainShape();

    float theta = 0;
    
    // This has to go backwards so that the objects  bounce off the top of the surface
    // JJS 8.1.2017: I tested reversing the chain and it still worked? Left original.
    // This "edgechain" will only work in one direction!
    for (float x = width+10; x > -10; x -= 5) {
      float y = map(cos(theta)+cos(theta/3),-2,2,100,height-30);
      theta += 0.15;

      // Store the vertex in screen coordinates
      surface.add(new Vec2(x,y));

    }

    // Build an array of vertices in Box2D coordinates
    Vec2[] vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = box2d.coordPixelsToWorld(surface.get(i));
      vertices[i] = edge;
    }
    
    chain.createChain(vertices,vertices.length);

    // The edge chain is now attached to a body via a fixture
    BodyDef bd = new BodyDef();
    bd.position.set(0.0f,0.0f);
    Body body = box2d.createBody(bd);

    // use default properties
    body.createFixture(chain,1);

  }

  // A simple function to just draw the edge chain as a series of vertex points
  void display() {
    strokeWeight(2);
    stroke(0);
    noFill();
    beginShape();
    for (Vec2 v: surface) {
      vertex(v.x,v.y);
    }
    endShape();
  }

}