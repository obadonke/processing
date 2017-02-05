class PathTarget implements ITarget {
  Path path;
  PVector targetLocation;
  PVector pathVector;
  
  PathTarget(Path p) {
    path = p;
  }
  
  PVector getLocation(IVehicle hunter) {
    Path.Segment seg = path.getSegmentClosestToPoint(hunter.getLocation());
    pathVector = PVector.sub(seg.end, seg.start);
    pathVector.normalize();

    PVector hunterLocation = hunter.getLocation();
    PVector predictedLocation = hunter.getVelocity();
    predictedLocation.normalize();
    float dotPathPredictedLocation = pathVector.dot(predictedLocation);
    predictedLocation.mult(LOOK_AHEAD);
    predictedLocation.add(hunterLocation);
    
    PVector pathNormalPoint = seg.lineNormalPoint.copy();
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