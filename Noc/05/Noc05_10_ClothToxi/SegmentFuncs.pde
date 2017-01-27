interface ISegmentFunc {
  void DoSegment(Particle a, Particle b);
}

class SegmentDrawer implements ISegmentFunc {
  void DoSegment(Particle a, Particle b) {
    line(a.x, a.y, b.x, b.y);
  }
}

class SegmentSpringMaker implements ISegmentFunc {
  float len;
  float strength;
  
  SegmentSpringMaker(float len, float strength) {
    this.len = len;
    this.strength = strength;
  }
  
  void DoSegment(Particle a, Particle b) {
     VerletSpring2D spring = new VerletSpring2D(a, b, len, strength);
     physics.addSpring(spring);
  }
}