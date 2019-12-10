interface IVehicle {
  PVector getVelocity();
  PVector getLocation();
}

interface ITarget {
  void display();
  PVector getLocation(IVehicle hunter);
}