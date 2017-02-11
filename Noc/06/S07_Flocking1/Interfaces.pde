interface IBoid {
  PVector getVelocity();
  PVector getLocation();
  PVector calcSteerForceFromDesired(PVector desired);
}

interface ITarget {
  void display();
  PVector getLocation(IBoid hunter);
}

interface IBehaviour {
  PVector getForce(IBoid vehicle);
}
