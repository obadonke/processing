int[] randomCounts;
int baseColor = 285;

void setup() {
  size(640, 240);
  colorMode(HSB,360,100,100);
  randomCounts = new int[30];
}

void draw() {
  baseColor = int(map(mouseX,0,width,0,360));
  background(baseColor,13,20);

  int index = int(random(randomCounts.length));
  randomCounts[index]++;


  if (mousePressed && mouseButton == LEFT) {
    drawSimpleCount();
  } else {
    drawScaledCount();
  }
}

void setColor(int index) {
  int gray = int(map(index, 0, randomCounts.length-1, 70, 100));
  stroke(baseColor,70,gray-20);
  fill(baseColor,70,gray);
}

void drawSimpleCount() {
  int w = width/randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++) {
    setColor(x);
    rect(x*w, height-randomCounts[x], w-1, randomCounts[x]);
  }
}

void drawScaledCount() {
  float maxCount = 1;
  float minCount = randomCounts[0];

  for (int x = 0; x < randomCounts.length; x++) {
    float curCount = randomCounts[x];
    if (curCount > maxCount) {
      maxCount = curCount;
    } else if (curCount < minCount) {
      minCount = curCount/3;
    }
  }

  float maxDiff = maxCount-minCount;

  int w = width/randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++) {
    setColor(x);
    float curDiff = randomCounts[x]-minCount;
    float curHeight = (maxDiff == 0) ? height : height*curDiff/maxDiff;

    rect(x*w, height-curHeight, w-1, curHeight);
  }
}