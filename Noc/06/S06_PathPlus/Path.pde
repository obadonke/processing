class Path {
  class Segment {
    PVector start;
    PVector end;
    PVector lineNormalPoint;
    
    Segment() {
    }
    
    Segment(PVector s, PVector e, PVector lnp) {
      start = s;
      end = e;
      lineNormalPoint = lnp;
    }
  }
  
  ArrayList<PVector> points;
  float radius;
  
  Path(ArrayList<PVector> points, float r) {
    this.points = points;
    radius = r;
  }
  
  void setPoints(ArrayList<PVector> points) {
    this.points = points;
  }
  
  void display() {
    strokeWeight(radius*2);
    stroke(0,100);
    noFill();
    drawLine();
    strokeWeight(1);
    stroke(0);
    drawLine();    
  }
  
  void drawLine() {
    beginShape();
    for (PVector p: points) {
      vertex(p.x, p.y);
    }
    endShape();
  }
  
  PVector getLineNormalPoint(PVector start, PVector end, PVector point) {
    PVector pathToPoint = PVector.sub(point, start);
    PVector lineVector = PVector.sub(end, start);
    float lineLength = lineVector.mag();
    lineVector.normalize();
    float distFromStartToNormalPoint = constrain(pathToPoint.dot(lineVector),0,lineLength);
    lineVector.mult(distFromStartToNormalPoint);
    lineVector.add(start);
    return lineVector;
 }
 
 Segment getSegmentClosestToPoint(PVector point) {
   Iterator<PVector> iterator = points.iterator();
   Segment seg = new Segment();
   
   float minDistFromSeg = Float.MAX_VALUE;
   PVector segStart = iterator.next();
   PVector segEnd;
   while (iterator.hasNext()) {
     segEnd = iterator.next();
     PVector np = getLineNormalPoint(segStart, segEnd, point);
     float dist = np.dist(point);
     if (dist < minDistFromSeg) {
       seg.lineNormalPoint = np;
       seg.start = segStart;
       seg.end = segEnd;
       minDistFromSeg = dist;
     }
     segStart = segEnd;
   }
   return seg;
 }

  float getRadius() {
    return radius;
  }
}