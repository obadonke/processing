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

  Transform copy() {
    return new Transform(translation, rotation, scale);
  }

  Transform sub(Transform t) {
    translation.sub(t.translation);
    rotation -= t.rotation;
    scale -= t.scale;
    return this;
  }
}