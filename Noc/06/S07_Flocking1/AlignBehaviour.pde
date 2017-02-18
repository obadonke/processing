class AlignBehaviour implements IBehaviour {
  final float ALMOST_ZERO = 0.001;
  final float NEIGHBOUR_DIST = 100;
  ArrayList<Boid> boids;

  AlignBehaviour(ArrayList<Boid> boids) {
    this.boids = boids;
  }

  PVector getForce(IBoid boid) {
    PVector refLocation = boid.getLocation();
    PVector alignForce = new PVector(0, 0);
    int numCloseBoids = 0;

    for (IBoid v : boids) {
      if (v == boid) continue;

      PVector distVector = PVector.sub(refLocation, v.getLocation());
      float dist = distVector.mag();

      if (dist > ALMOST_ZERO && dist < NEIGHBOUR_DIST) {
        alignForce.add(v.getVelocity());
        numCloseBoids++;
      }
    }

    if (numCloseBoids == 0) return null;

    alignForce.div(numCloseBoids);
    alignForce.setMag(boid.getMaxForce());

    return alignForce;
  }

  void display() {
    //   
  }
}
