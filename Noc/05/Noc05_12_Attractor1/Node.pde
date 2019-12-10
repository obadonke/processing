class Node extends VerletParticle2D {
  float diameter = 20;
  int id;
  color c;
  
  Node(int id, Vec2D loc) {
    super(loc);
    this.id = id;

    c = 175+(int)random(10);
    if (id == 0) {
      diameter = 25;
      c = 0;
    }
    
    physics.addBehavior(new AttractionBehavior2D(this, diameter*2, -1));    
  }
  
  void display() {
    fill(c, 150);
    stroke(0);
    ellipse(x, y, diameter, diameter);
  }
  
  float getRadius() {
    return diameter/2.0;
  }
}