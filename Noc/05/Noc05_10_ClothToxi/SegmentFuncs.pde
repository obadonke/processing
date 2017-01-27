interface ISegmentFunc {
  void DoSegment(Particle a, Particle b);
}

class SegmentDrawer implements ISegmentFunc {
  float restLen;
  
  SegmentDrawer(float restLen) {
    this.restLen = restLen;
    println(restLen);
  }
  
  void DoSegment(Particle a, Particle b) {
    float ratio = abs(a.distanceTo(b))/restLen;
    color c;
    
    if (ratio < 1) {
      c = color(0,200,0);
    } else if (ratio < 1.2) {
      c = color(0,0,0);
    } else {
      c = color(200+ratio,0,0);
    }
    stroke(c);
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