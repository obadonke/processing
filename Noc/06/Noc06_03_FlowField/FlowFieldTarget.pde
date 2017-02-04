public class FlowFieldTarget implements ITarget {
  FlowField flowField;

  FlowFieldTarget(FlowField flowField) {
    this.flowField = flowField;
  }

  public PVector getLocation(IVehicle vehicle) {
    PVector futureLocation = vehicle.getLocation();
    PVector motion = vehicle.getVelocity();
    motion.normalize();
    motion.mult(TARGET_LOOK_AHEAD);
    futureLocation.add(motion);
    PVector newPosition = flowField.getFieldVectorAt(futureLocation.x, futureLocation.y);
    newPosition.setMag(WANDER_ARM_LENGTH);
    newPosition.add(vehicle.getLocation());
    return newPosition;
  }

  public void display() {
  }
}