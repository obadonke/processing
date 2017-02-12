
class SeekBehaviour implements IBehaviour {
  final float APPROACH_DISTANCE_FACTOR= 10;
  final boolean ALLOW_ARRIVAL = true;

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
    float approachDistance = APPROACH_DISTANCE_FACTOR*maxSpeed; 
    if (dist < approachDistance && ALLOW_ARRIVAL) {
      float speed = map(dist, 0, approachDistance, 0, maxSpeed);
      desired.limit(speed);
    } else {
      desired.limit(maxSpeed);
    }

    return desired;
  }
  
  void display() {
    target.display();
  }
}