// A pool of friction

private final float DefaultWellSize = 70.0;

class FrictionWell {
  PVector center;
  float coefficient;
  float wellSize;

  FrictionWell(PVector center, float frictionCoefficient) {
    this.center = center;
    this.coefficient = frictionCoefficient;
    this.wellSize = DefaultWellSize;
  }
  
  boolean isResistant() {
    return coefficient > 0;
  }
  
  boolean containsPoint(PVector point) {
    return (PVector.sub(point, center).mag() < wellSize);
  }

  void display() {
    color c = isResistant() ? color(255,0,0) : color(255,0,255);
    stroke(c);
    noFill();
    ellipse(center.x,center.y, wellSize, wellSize);
  }
  
  float getFrictionCoefficient() {
    return coefficient;
  }
}