import java.util.*;

int[] randomCounts;
int mean = 20;
int sdeviation = 5;
int baseColor = 285;
Random generator;

void setup() {
  size(640, 240);
  colorMode(HSB, 360, 100, 100);
  randomCounts = new int[mean*2+1];
  generator = new Random();
}

void draw() {
  baseColor = int(map(mouseX, 0, width, 0, 360));
  background(baseColor, 13, 20);

  int index = (int)(mean + generator.nextGaussian()*sdeviation);
  randomCounts[index]++;


  if (mousePressed && mouseButton == LEFT) {
    drawSimpleCount();
  } else {
    drawScaledCount();
  }
}

void setColor(int index) {
  int gray = int(map(index, 0, randomCounts.length-1, 70, 100));
  stroke(baseColor, 70, gray-20);
  fill(baseColor, 70, gray);
}

void drawSimpleCount() {
  int w = width/randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++) {
    setColor(x);
    rect(x*w, height-randomCounts[x], w-1, randomCounts[x]);
  }
}

void drawScaledCount() {
  int smallestBarHeight = 0;
  int maxBarExtension = height - (smallestBarHeight+2);

  float maxCount;
  float minCount = maxCount = randomCounts[0];

  for (int x = 0; x < randomCounts.length; x++) {
    float curCount = randomCounts[x];
    if (curCount > maxCount) {
      maxCount = curCount;
    } else if (curCount < minCount) {
      minCount = curCount;
    }
  }

  float maxDiff = maxCount-minCount;

  int w = width/randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++) {
    setColor(x);
    float curDiff = randomCounts[x]-minCount;
    float curHeight = (maxDiff == 0) ? height : smallestBarHeight + (maxBarExtension*curDiff/maxDiff);

    rect(x*w, height-curHeight, w-1, curHeight, 4, 4, 0, 0);
  }
}