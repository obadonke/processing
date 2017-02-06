interface IVehicle {
  PVector getVelocity();
  PVector getLocation();
  PVector calcSteerForceFromDesired(PVector desired);
}

interface ITarget {
  void display();
  PVector getLocation(IVehicle hunter);
}

interface IBehaviour {
  PVector getForce(IVehicle vehicle);
}