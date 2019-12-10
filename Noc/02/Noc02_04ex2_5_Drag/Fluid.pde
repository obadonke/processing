// Fluid will be a source of drag

class Fluid {
  float dragCoefficient;  // consider this to be density of liquid * Coefficient of drag
  int fromX, fromY;
  int fluidWidth, fluidDepth;

  Fluid(float dragCoef, int fromX, int fromY, int w, int h) {
    this.dragCoefficient = dragCoef;
    this.fromX = fromX;
    this.fromY = fromY;
    this.fluidWidth = w;
    this.fluidDepth = h;
  }

  void draw() {
    fill(0, 50);
    noStroke();
    rect(fromX, fromY, fluidWidth, fluidDepth);
  }

  boolean isCircleInside(Circle circle) {
    return (circle.center.y - circle.radius) > (fromY);
  }

  Line getSurfaceLine() {
    return new Line(new PVector(fromX, fromY), new PVector(1,0));
  }
  
  boolean contains(PVector pt) {
    return pt.y > fromY;
  }
}