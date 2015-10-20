class Transform {
  PVector translation = new PVector(0, 0);
  float rotation = 0;
  float scale = 1;

  Transform()
  {
  }

  Transform(PVector t, float r, float s)
  {
    translation = t.copy();
    rotation = r;
    scale = s;
  }

  void set(float tx, float ty, float r, float s) {
    translation.set(tx,ty);
    rotation = r;
    scale = s;
  }
  
  void set(Transform t) {
    set(t.translation.x,t.translation.y, t.rotation, t.scale);
  }
  
  Transform copy() {
    return new Transform(translation, rotation, scale);
  }

  Transform sub(Transform t) {
    translation.sub(t.translation);
    rotation -= t.rotation;
    scale -= t.scale;
    return this;
  }

  /// multiply all transforms by a scalar
  Transform mult(float s) {
    translation.mult(s);
    rotation = rotation*s;
    scale = scale*s;
    return this;
  }
  
}