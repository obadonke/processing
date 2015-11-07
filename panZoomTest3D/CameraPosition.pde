class CameraPosition {
  private float eyeDistance;
  private PVector eyeDirection;
  private PVector lookAt;
  private PVector up;
  final float MIN_EYE_DISTANCE = 0.5;
  
  CameraPosition(float distToCamera) {
    eyeDistance = distToCamera;
    eyeDirection = new PVector(0, 0, 1);
    lookAt = new PVector(0, 0, 0);
    up = new PVector(0, 1, 0);
    println(up.cross(eyeDirection));
  }
  
  PVector getEyePos() {
    PVector eyeOffset = PVector.mult(eyeDirection,eyeDistance);
    return PVector.add(lookAt, eyeOffset);
  }
  
  PVector getLookAt() {
    return lookAt;
  }
  
  PVector getUp() {
    return up;
  }
  
  PVector getRight() {
    return up.cross(eyeDirection);
  }
  
  void Translate(PVector translation)
  {
    PVector globalTranslation = PVector.mult(getRight(),translation.x);
    globalTranslation.add(PVector.mult(up,translation.y));
    globalTranslation.add(PVector.mult(eyeDirection,translation.z));
    lookAt.add(globalTranslation);
  }
  
  void Zoom(float factor)
  {
    if (eyeDistance * factor < MIN_EYE_DISTANCE) {
      return;
    }
    
    eyeDistance *= factor;
  }
}