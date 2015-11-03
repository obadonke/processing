class CameraPosition {
  private PVector eyeOffset;
  private PVector lookAt;
  private PVector up;

  CameraPosition(float distToCamera) {
    eyeOffset = new PVector(0, 0, distToCamera);
    lookAt = new PVector(0, 0, 0);
    up = new PVector(0, 1, 0);
  }
  
  PVector getEyePos() {
    return PVector.add(lookAt, eyeOffset);
  }
  
  PVector getLookAt() {
    return lookAt;
  }
  
  PVector getUp() {
    return up;
  }
}