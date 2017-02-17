class MouseTarget implements ITarget {
  PVector mouseLoc;

  MouseTarget() {
  }

  PVector getLocation(IBoid boid) {
    PVector boidLocation = boid.getLocation();
    mouseLoc = new PVector(mouseX, mouseY);
    return PVector.sub(mouseLoc, boidLocation);
  }

  void display() {
    if (mouseLoc == null) return;

    stroke(200);
    strokeWeight(1);
    noFill();
    ellipseMode(CENTER);
    ellipse(mouseLoc.x, mouseLoc.y, 50, 50);
  }
}
