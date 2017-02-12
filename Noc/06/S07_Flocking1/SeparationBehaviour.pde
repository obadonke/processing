class SeparationBehaviour implements IBehaviour {
  final float ALMOST_ZERO = 0.001;
  final float MIN_SEPARATION = 20;
  ArrayList<Boid> boids;

  SeparationBehaviour(ArrayList<Boid> boids) {
    this.boids = boids;
  }

  PVector getForce(IBoid boid) {
    PVector refLocation = boid.getLocation();
    PVector separationForce = new PVector(0, 0);
    int numCloseBoids = 0;

    for (IBoid v : boids) {
      if (v == boid) continue;
      
      PVector fleeVector = PVector.sub(refLocation, v.getLocation());
      float dist = fleeVector.mag();

      if (dist > ALMOST_ZERO && dist < MIN_SEPARATION) {
        fleeVector.normalize();
        separationForce.add(fleeVector);
        numCloseBoids++;
      }
    }

    if (numCloseBoids == 0) return separationForce;

    separationForce.div(numCloseBoids);
    separationForce.setMag(boid.getMaxForce());

    return separationForce;
  }
  
  void display() {
    //   
  }
}
