interface IRandom {
   // return next random number in range [0,1)
   float getRandom();
}

// return next Monte Carlo number in range 0 (inclusive) to 1 (exclusive)
float nextMonteCarlo(boolean isExponential)
  {
    while (true) {
      float r1 = random(0,1);
      float r2 = random(0,1);
      if (isExponential && r2 < r1*r1) {
        return r1;
      } else if (!isExponential && r2 < r1) {
        return r1;
      }
    }
  }

class MonteCarloLinear implements IRandom {
  float getRandom() {
    return nextMonteCarlo(false);
  }
}

class MonteCarloExponential implements IRandom {
  float getRandom() {
    return nextMonteCarlo(true);
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