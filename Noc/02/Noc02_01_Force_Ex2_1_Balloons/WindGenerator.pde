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
  
  PVector getWindAt(PVector location) {
    float amplitude = noise(1000+location.x,1000+location.y)*maxWind;
    return new PVector(mapLocationToDirectionComponent(location.x)*amplitude, 0);
  }
  
  float mapLocationToDirectionComponent(float location) {
    return map(noise(seed + location/noiseResolution),0,1,-1,1);
  }
}