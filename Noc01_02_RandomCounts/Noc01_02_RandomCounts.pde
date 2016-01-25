int[] randomCounts;

void setup() {
  size(640,240);
  randomCounts = new int[15];
}

void draw() {
  background(255);
  
  int index = int(random(randomCounts.length));
  randomCounts[index]++;
  
  
  if (mousePressed && mouseButton == LEFT) {
    drawSimpleCount();
  }
  else {
    drawScaledCount();
  }
}

void setColor(int index) {
  int gray = int(map(index,0,randomCounts.length,200,255));
  stroke(gray);
  fill(gray-50);

}

void drawSimpleCount() {
  int w = width/randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++) {
    setColor(x);
    rect(x*w, height-randomCounts[x],w-1,randomCounts[x]);
  }
}

void drawScaledCount() {
  float maxCount = 1;
  for (int x = 0; x < randomCounts.length; x++) {
    float curCount = randomCounts[x];
    if (curCount > maxCount) maxCount = curCount;
  }
  
  int w = width/randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++) {
    setColor(x);
    float curCount = randomCounts[x];
    float curHeight = height*curCount/maxCount;
    
    rect(x*w, height-curHeight,w-1,curHeight);
  }  
}