class WanderTarget implements ITarget {
  PVector hunterLastLocation;
  PVector wanderCenter;
  PVector targetLocation;

  WanderTarget() {
  }

  void updateTarget(IVehicle hunter) {
    // move to a new location based on hunter's current velocity
    hunterLastLocation = hunter.getLocation();
    wanderCenter = hunter.getVelocity();
    wanderCenter.normalize();
    wanderCenter.mult(WANDER_ARM_LENGTH);
    wanderCenter.add(hunterLastLocation);
    float theta = random(TWO_PI);
    targetLocation = new PVector(sin(theta), cos(theta));
    targetLocation.mult(WANDER_RADIUS);
    targetLocation.add(wanderCenter);
  }

  void displayTarget() {
    stroke(200);
    strokeWeight(1);
    noFill();
    ellipseMode(CENTER);
    ellipse(wanderCenter.x, wanderCenter.y, WANDER_RADIUS*2, WANDER_RADIUS*2);
    line(hunterLastLocation.x, hunterLastLocation.y, wanderCenter.x, wanderCenter.y);
    line(wanderCenter.x, wanderCenter.y, targetLocation.x, targetLocation.y);
  }

  PVector getTargetLocation() {
    return targetLocation;
  }
}