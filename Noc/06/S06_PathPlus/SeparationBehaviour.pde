class SeparationBehaviour implements IBehaviour {
  final float ALMOST_ZERO = 0.001;
  float minSeparation = MIN_SEPARATION;
  ArrayList<Vehicle> vehicles;

  SeparationBehaviour(ArrayList<Vehicle> vehicles) {
    this.vehicles = vehicles;
  }

  PVector getForce(IVehicle vehicle) {
    PVector refLocation = vehicle.getLocation();
    PVector separationForce = new PVector(0, 0);
    int numCloseVehicles = 0;

    for (IVehicle v : vehicles) {
      if (v == vehicle) continue;
      
      PVector fleeVector = PVector.sub(refLocation, v.getLocation());
      float dist = fleeVector.mag();

      if (dist > ALMOST_ZERO && dist < minSeparation) {
        fleeVector.normalize();
        separationForce.add(fleeVector);
        numCloseVehicles++;
      }
    }

    if (numCloseVehicles == 0) return separationForce;

    separationForce.div(numCloseVehicles);
    separationForce.setMag(MAX_SPEED);

    return vehicle.calcSteerForceFromDesired(separationForce);
  }
}