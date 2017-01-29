class Node extends VerletParticle2D {
  final float diameter = 20;
  
  Node(Vec2D loc) {
    super(loc);
  }
  
  void display() {
    fill(175+random(2), 150);
    stroke(0);
    ellipse(x, y, diameter, diameter);
  }
  
  float getRadius() {
    return diameter/2.0;
  }
}