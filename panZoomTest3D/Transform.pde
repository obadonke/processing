class Transform {
  PVector translation = new PVector(0, 0, 0);
  PVector rotation = new PVector(0, 0, 0);
  float scale = 1;

  Transform()
  {
  }

  Transform(PVector t, PVector r, float s)
  {
    translation = t.copy();
    rotation = r.copy();
    scale = s;
  }

  
  Transform EmptyTransform() {
    return new Transform(new PVector(0,0,0), new PVector(0,0,0), 1);
  }
  
  void set(float tx, float ty, float tz, float rx, float ry, float rz, float s) {
    translation.set(tx, ty, tz);
    rotation.set(rx, ry, rz);
    scale = s;
  }
  
  void set(Transform t) {
    translation = t.translation.copy();
    rotation = t.rotation.copy();
    scale = t.scale;
  }
  
  Transform copy() {
    return new Transform(translation, rotation, scale);
  }

  Transform sub(Transform t) {
    translation.sub(t.translation);
    rotation.sub(t.rotation);
    scale -= t.scale;
    return this;
  }

  /// multiply all transforms by a scalar
  Transform mult(float s) {
    translation.mult(s);
    rotation.mult(s);
    scale = scale*s;
    return this;
  }
  
}