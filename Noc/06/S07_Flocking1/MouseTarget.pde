class MouseTarget implements ITarget {
  PVector mouseLoc;

  MouseTarget() {
  }

  PVector getLocation(IBoid boid) {
    mouseLoc = new PVector(mouseX, mouseY);

    if (boid.getLocation().dist(mouseLoc) > 150) {
      return null;
    }
    return mouseLoc;
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
