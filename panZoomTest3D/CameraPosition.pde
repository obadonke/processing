class CameraPosition {
  private float eyeDistance;
  private PVector eyeDirection;
  private PVector lookAt;
  private PVector up;

  CameraPosition(float distToCamera) {
    eyeDistance = distToCamera;
    eyeDirection = new PVector(0, 0, 1);
    lookAt = new PVector(0, 0, 0);
    up = new PVector(0, 1, 0);
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
  
  void Translate(PVector translation)
  {
    //TODO: move with respect to current orientation.
    lookAt.add(translation);
  }
  
  void Zoom(float amount)
  {
    if (eyeDistance + amount <= 0) {
      return;
    }
    
    eyeDistance += amount;
  }
}