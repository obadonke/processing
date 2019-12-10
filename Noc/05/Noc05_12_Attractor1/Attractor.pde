class Attractor extends Node {
  float strength;
  
  Attractor(int id, Vec2D loc, float diameter, float strength) {
    super(id, loc);
    
    this.diameter = diameter;
    physics.addBehavior(new AttractionBehavior2D(this, width, strength));
  }
}