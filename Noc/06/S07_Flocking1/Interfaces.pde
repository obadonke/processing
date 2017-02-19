interface IBoid {
  PVector getVelocity();
  PVector getLocation();
  float getMaxForce();
  void debugDisplay();
}

interface ITarget {
  void display();
  PVector getLocation(IBoid hunter);
}

interface IBehaviour {
  void display();
  PVector getForce(IBoid vehicle);
}