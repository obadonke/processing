class SeekBehaviour implements IBehaviour {
  ITarget target;
  float maxSpeed;
  
  SeekBehaviour(ITarget target, float maxSpeed) {
    this.target = target;
    this.maxSpeed = maxSpeed;
  }

  PVector getForce(IBoid boid) {
    return calcSeekForce(boid, target.getLocation(boid));
  }

  PVector calcSeekForce(IBoid boid, PVector target) {
    PVector location = boid.getLocation();
    PVector desired = PVector.sub(target, location);

    float dist = desired.mag();
    if (dist < APPROACH_DISTANCE && ALLOW_ARRIVAL) {
      float speed = map(dist, 0, APPROACH_DISTANCE, 0, maxSpeed);
      desired.limit(speed);
    } else {
      desired.limit(maxSpeed);
    }

    return boid.calcSteerForceFromDesired(desired);
  }
}