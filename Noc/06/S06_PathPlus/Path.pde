class Path {
  ArrayList<PVector> points;
  float radius;
  
  Path(ArrayList<PVector> points, float r) {
    this.points = points;
    radius = r;
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
}

class SimplePath {
  Path path;
  PVector start;
  PVector end;
  
  SimplePath(PVector s, PVector e, float r) {
    start = s;
    end = e;
    ArrayList<PVector> pathPoints = new ArrayList<PVector>();
    pathPoints.add(s);
    pathPoints.add(e);
    
    path = new Path(pathPoints, r);
  }
  
  void display() {
    path.display();
  }
  
  float getRadius() {
    return path.radius;
  }
  
  PVector getNormalPoint(PVector point) {
    return path.getLineNormalPoint(start, end, point);
 }

}