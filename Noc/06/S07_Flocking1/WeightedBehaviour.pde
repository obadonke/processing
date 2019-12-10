class WeightedBehaviour {
  float weight;
  IBehaviour behaviour;
  private IFactor factor;
  
  WeightedBehaviour(IBehaviour b, IFactor factor) {
    this.behaviour = b;
    this.factor = factor;
  }
  
  float getWeight() {
    return factor.getFactor();
  }
}