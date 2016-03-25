// Wind generator

class WindGenerator {
  float noiseResolution = 100;
  float maxWind = 1.0;
  float seed = 100;
  
  PVector windHeadingVector = new PVector(1,0);
  
  WindGenerator(float maxWind, float noiseResolution) {
    this.maxWind = maxWind;
    this.noiseResolution = noiseResolution;
  }
  
  void setSeed(float seed) {
    this.seed = seed;
  }
  
  PVector getWindForce() {
    float amplitude = map(noise((float)(seed + frameCount)/noiseResolution),0,1,-1,1)*maxWind;
    return new PVector(amplitude, 0);
  }
}