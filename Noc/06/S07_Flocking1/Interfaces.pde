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

class WeightedBehaviour {
  float weight;
  IBehaviour behaviour;
  
  WeightedBehaviour(IBehaviour b, float weight) {
    this.behaviour = b;
    this.weight = weight;
  }
}