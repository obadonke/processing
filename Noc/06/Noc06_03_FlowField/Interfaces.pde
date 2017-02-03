interface IVehicle {
  PVector getVelocity();
  PVector getLocation();
}

interface ITarget {
  void updateTarget(IVehicle hunter);
  void displayTarget();
  PVector getTargetLocation();
}