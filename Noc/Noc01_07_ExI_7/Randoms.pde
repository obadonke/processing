interface IRandom {
   // return next random number in range [0,1)
   float getRandom();
}


class MonteCarlo implements IRandom {
  IRandom valueGen;
  boolean isExponential;
  
  MonteCarlo(boolean isExponential, IRandom valueGen)
  {
    this.valueGen = valueGen;
    this.isExponential = isExponential;
  }
  
  float getRandom() {
    return nextMonteCarlo(isExponential);
  }

 // return next Monte Carlo number in range 0 (inclusive) to 1 (exclusive)
 private float nextMonteCarlo(boolean isExponential)
 {
    while (true) {
      float r1 = valueGen.getRandom();
      float r2 = valueGen.getRandom();
      if (isExponential && r2 < r1*r1) {
        return r1;
      } else if (!isExponential && r2 < r1) {
        return r1;
      }
    }
  }
}

class SimpleRandom implements IRandom {
  float getRandom() {
    return random(1);
  }
}

class PerlinNoise implements IRandom {
  float seed;
  float step;
  
  PerlinNoise(float seed, float step)
  {
    this.seed = seed;
    this.step = step;
  }
  
  float getRandom() {
    seed += step;
    return noise(seed);
  }
  
}