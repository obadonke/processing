class CohesionBehaviour implements IBehaviour {
  SeekBehaviour innerSeek;
  CohesionTarget target;

  CohesionBehaviour(ArrayList<Boid> boids, float maxSpeed) {
    target = new CohesionTarget(boids);
    innerSeek = new SeekBehaviour(target, maxSpeed);
  }

  PVector getForce(IBoid boid) {
    return innerSeek.getForce(boid);
  }

  void display() {
    //
  }

  class CohesionTarget implements ITarget {
    ArrayList<Boid> boids;

    CohesionTarget(ArrayList<Boid> boids) {
      this.boids = boids;
    }

    PVector getLocation(IBoid boid) {
      PVector averageLoc = new PVector(0,0);
      int numCloseBoids = 0;

      for (IBoid b: boids) {
        PVector bLoc = b.getLocation();
        float dist = boid.getLocation().dist(bLoc);

        if (dist > BoidParams.ALMOST_ZERO && dist < BoidParams.NEIGHBOUR_DIST) {
          averageLoc.add(bLoc);
          numCloseBoids++;
        }
      }

      if (numCloseBoids == 0) return null;

      averageLoc.div(numCloseBoids);
      return averageLoc;
    }

    void display() {
      //
    }
  }
}
