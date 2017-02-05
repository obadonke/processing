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
    float dotPathPredictedLocation = pathVector.dot(predictedLocation);
    predictedLocation.mult(LOOK_AHEAD);
    predictedLocation.add(hunterLocation);
    
    PVector pathNormalPoint = path.getNormalPoint(predictedLocation);
    float distPredictFromNormal = pathNormalPoint.dist(predictedLocation);
    
    if (distPredictFromNormal < path.getRadius()/2) {
      return predictedLocation;
    }
    
    // course correct
    targetLocation = pathVector.copy();
    float lookAhead = ALLOW_REVERSE && (dotPathPredictedLocation < 0) ? -LOOK_AHEAD : LOOK_AHEAD;
    targetLocation.mult(lookAhead);
    targetLocation.add(pathNormalPoint);
    return targetLocation;
  }

  void display() {
    //stroke(200);
    //strokeWeight(1);
    //noFill();
  }
}