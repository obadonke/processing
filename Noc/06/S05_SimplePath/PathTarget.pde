class PathTarget implements ITarget {
  SimplePath path;
  PVector targetLocation;
  PVector pathVector;
  
  PathTarget(SimplePath p) {
    path = p;
  }
  
  PVector getLocation(IVehicle hunter) {
    pathVector = PVector.sub(path.end, path.start);
    pathVector.normalize();

    PVector hunterLocation = hunter.getLocation();
    PVector predictedLocation = hunter.getVelocity();
    predictedLocation.normalize();
    predictedLocation.mult(LOOK_AHEAD);
    predictedLocation.add(hunterLocation);
    
    PVector pathNormalPoint = getNormalPoint(predictedLocation);
    float distPredictFromNormal = pathNormalPoint.dist(predictedLocation);
    
    if (distPredictFromNormal < path.radius/2) {
      return predictedLocation;
    }
    
    // course correct
    targetLocation = pathVector.copy();
    targetLocation.mult(LOOK_AHEAD);
    targetLocation.add(pathNormalPoint);
    return targetLocation;
  }

  void display() {
    //stroke(200);
    //strokeWeight(1);
    //noFill();
  }

 PVector getNormalPoint(PVector predictedLocation) {
    PVector pathToPredicted = PVector.sub(predictedLocation, path.start);
    float distFromStartToNormalPoint = pathToPredicted.dot(pathVector);
    PVector np = pathVector.copy();
    np.mult(distFromStartToNormalPoint);
    return np.add(path.start);
 }
}