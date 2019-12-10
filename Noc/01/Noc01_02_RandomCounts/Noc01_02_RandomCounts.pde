int[] randomCounts;
int baseColor = 285;
int minCount;
int maxCount;
PFont font;

void setup() {
  size(640, 240);
  colorMode(HSB, 360, 100, 100);
  randomCounts = new int[30];
  font = createFont("Arial", 18, true);
}

void draw() {
  baseColor = int(map(mouseX, 0, width, 0, 360));
  background(baseColor, 13, 20);

  int index = int(random(randomCounts.length));
  randomCounts[index]++;

  calcMinMaxCounts();

  if (mousePressed && mouseButton == LEFT) {
    drawScaledCount();
  } else {
    drawSimpleCount();
  }
}

void calcMinMaxCounts() {
  maxCount = minCount = randomCounts[0];

  for (int x = 0; x < randomCounts.length; x++) {
    int curCount = randomCounts[x];
    if (curCount > maxCount) {
      maxCount = curCount;
    } else if (curCount < minCount) {
      minCount = curCount;
    }
  }
}

void drawSimpleCount() {
  int adjustment = 0;

  if (minCount > 50) {
    adjustment = minCount-50;
  }

  int w = width/randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++) {
    setColor(x);
    int curHeight = randomCounts[x]-adjustment;
    rect(x*w, height-curHeight, w-1, curHeight, 4, 4, 0, 0);
  }

  drawLabel(String.format("adj = +%1$d   [LMB->scaled]", adjustment));
}

void drawScaledCount() {

  // reduce min to guarantee we always have a stalk
  int smallestBarHeight = 10;
  int maxBarExtension = height - (smallestBarHeight+2);

  float maxDiff = maxCount-minCount;

  int w = width/randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++) {
    setColor(x);
    float curDiff = randomCounts[x]-minCount;
    float curHeight = (maxDiff == 0) ? height : smallestBarHeight + (maxBarExtension*curDiff/maxDiff);

    rect(x*w, height-curHeight, w-1, curHeight, 4, 4, 0, 0);
  }

  drawLabel(String.format("max diff=%1$d", int(maxDiff)));
}

void setColor(int index) {
  float indexToRadians = map(index, 0, randomCounts.length-1, 0, PI);
  float gray = 60+ sin(indexToRadians)*40;
  stroke(baseColor, 80, gray-20);
  fill(baseColor, 80, gray);
}

void drawLabel(String s) {
  fill(0, 0, 100);
  text(s, 0, height-2);
}