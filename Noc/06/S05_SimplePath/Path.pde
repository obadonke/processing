class SimplePath {
  PVector start;
  PVector end;
  float radius;
  
  SimplePath(PVector s, PVector e, float r) {
    start = s;
    end = e;
    radius = r;
  }
  
  void display() {
    strokeWeight(radius*2);
    stroke(0,100);
    noFill();
    line(start.x,start.y, end.x, end.y);
    strokeWeight(1);
    stroke(0);
    line(start.x,start.y, end.x, end.y);    
  }
}