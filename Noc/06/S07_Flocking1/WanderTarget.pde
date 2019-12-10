
class WanderTarget implements ITarget {
  final float WANDER_ARM_LENGTH = 100;
  final float WANDER_RADIUS = WANDER_ARM_LENGTH/2.5;
  
  PVector hunterLocation;
  PVector wanderCenter;
  PVector targetLocation;

  WanderTarget() {
  }

  PVector getLocation(IBoid hunter) {
    // move to a new location based on hunter's current velocity
    hunterLocation = hunter.getLocation();
    wanderCenter = hunter.getVelocity();
    wanderCenter.normalize();
    wanderCenter.mult(WANDER_ARM_LENGTH);
    wanderCenter.add(hunterLocation);
    float theta = random(TWO_PI);
    targetLocation = new PVector(sin(theta), cos(theta));
    targetLocation.mult(WANDER_RADIUS);
    targetLocation.add(wanderCenter);
    return targetLocation;
  }

  void display() {
    if (hunterLocation == null || wanderCenter == null) return;
    
    stroke(200);
    strokeWeight(1);
    noFill();
    ellipseMode(CENTER);
    ellipse(wanderCenter.x, wanderCenter.y, WANDER_RADIUS*2, WANDER_RADIUS*2);
    line(hunterLocation.x, hunterLocation.y, wanderCenter.x, wanderCenter.y);
    line(wanderCenter.x, wanderCenter.y, targetLocation.x, targetLocation.y);
  }
}