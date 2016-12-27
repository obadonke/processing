// Fluid will be a source of drag

class Fluid {
  float dragCoefficient;
  int fromX, fromY;
  int fluidWidth, fluidHeight;
  
  Fluid(float dragCoef, int fromX, int fromY, int w, int h) {
    this.dragCoefficient = dragCoef;
    this.fromX = fromX;
    this.fromY = fromY;
    this.fluidWidth = w;
    this.fluidHeight = h;
  }
  
  void draw() {
    fill(0,50);
    noStroke();
    rect(fromX, fromY, fluidWidth, fluidHeight);
  }
  
  void contains(PVector pt) {
    
  }
}