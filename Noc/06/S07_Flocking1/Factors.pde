interface IFactor {
  float getFactor();
}

class ConstantFactor implements IFactor {
  float factor;
  
  ConstantFactor(float factor) {
    this.factor = factor;
  }
  
  float getFactor() {
    return factor;
  }
}

class SineFactor implements IFactor {
  float minVal;
  float maxVal;
  int framesPerCycle;
  
  SineFactor(int framesPerCycle, float minVal, float maxVal) {
    this.framesPerCycle = framesPerCycle;
    this.minVal = minVal;
    this.maxVal = maxVal;
  }
  
  float getFactor() {
    int stageInCycle = frameCount % framesPerCycle;
    float theta = map(stageInCycle,0,framesPerCycle,0,TWO_PI);
    float factor = map(sin(theta),-1,1,minVal,maxVal); 
    return factor;
  }
}