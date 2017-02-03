public class FlowFieldTargetFactory {
  FlowField flowField;
  FlowFieldTargetFactory(FlowField flowField) {
    this.flowField = flowField;
  }
  
  public ITarget createTarget() {
    return new ITarget() {
      PVector location;
      
      public void updateTarget(IVehicle vehicle) {
        PVector futureLocation = vehicle.getLocation();
        PVector motion = vehicle.getVelocity();
        //float speed = motion.mag();
        motion.normalize();
        motion.mult(10);
        futureLocation.add(motion);
        PVector newPosition = flowField.getFieldVectorAt(futureLocation.x,futureLocation.y);
        newPosition.setMag(WANDER_ARM_LENGTH);
        location = newPosition.add(vehicle.getLocation());
      }
      
      public PVector getTargetLocation() {
        return location;
      }
      
      public void displayTarget() { }
    };
  }
}