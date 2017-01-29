class Node extends VerletParticle2D {
  float diameter = 20;
  int id;
  
  Node(int id, Vec2D loc) {
    super(loc);
    this.id = id;
    if (id == 0) {
      diameter = 25;
    }
  }
  
  void display() {
    fill((id == 0) ? 0 : 175+random(2), 150);
    stroke(0);
    ellipse(x, y, diameter, diameter);
  }
  
  float getRadius() {
    return diameter/2.0;
  }
}