class PathTarget implements ITarget {
  final float LOOK_AHEAD = 60;
  final boolean ALLOW_REVERSE = true;

  Path path;
  PVector hunterLocation;
  PVector targetLocation;
  PVector pathVector;
  
  PathTarget(Path p) {
    path = p;
  }
  
  PVector getLocation(IBoid hunter) {
    Path.Segment seg = path.getSegmentClosestToPoint(hunter.getLocation());
    pathVector = PVector.sub(seg.end, seg.start);
    pathVector.normalize();

    hunterLocation = hunter.getLocation();
    PVector predictedLocation = hunter.getVelocity();
    predictedLocation.normalize();
    float dotPathPredictedLocation = pathVector.dot(predictedLocation);
    predictedLocation.mult(LOOK_AHEAD);
    predictedLocation.add(hunterLocation);
    
    PVector pathNormalPoint = seg.lineNormalPoint.copy();
    float distPredictFromNormal = pathNormalPoint.dist(predictedLocation);
    
    if (distPredictFromNormal < path.getRadius()) {
      targetLocation = predictedLocation;
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
    if (hunterLocation == null || targetLocation == null) return;
    
    stroke(200);
    strokeWeight(2);
    noFill();
    line(hunterLocation.x, hunterLocation.y, targetLocation.x, targetLocation.y);
  }
}