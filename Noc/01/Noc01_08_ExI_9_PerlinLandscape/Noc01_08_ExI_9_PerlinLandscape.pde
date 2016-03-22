// Nature of Code Exercise I.9. Render a 3D landscape based on Perlin Noise.

int mapSize = 45;
int tileSize = 30;
int[] heights = new int[mapSize*mapSize];
int maxHeight = tileSize*20;
float mapStep = 0.05;
PVector perlinOffset = new PVector(500,500);
PVector perlinStep = new PVector(0.05,0);
int lod = 3;
float fallOff = 0.5;
int textSize = 14;
int maxExtent = tileSize*mapSize/2;

void setup() {
  size(800, 600, P3D);
  colorMode(HSB,360,100,100);
  frameRate(24);
  println(maxExtent);
}

void draw() {
  background(0);
  fill(0,0,100);
  int textOffset = 5;
  textSize(textSize);
  text("Nature of Code. Perlin Noise Landscape",0,textSize+textOffset);
  String helpText = String.format("LOD: %d Left/Right", lod);
  text(helpText,0,textSize*2+textOffset);
  
  helpText = String.format("FallOff: %.2f Up/Down", fallOff);
  text(helpText,0,textSize*3+textOffset);
   
  noiseDetail(lod, fallOff);
  
  lights();
  translate(width/2,height/2,-maxExtent);
  rotateY(map(mouseX,0,width,HALF_PI+QUARTER_PI, PI));
  rotateX(map(mouseY,0,height, QUARTER_PI/2, QUARTER_PI));
  generateMap();
  perlinOffset.add(perlinStep);
  drawMap();
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case LEFT:
        decreaseLOD();
      break;
      case RIGHT:
        increaseLOD();
      break;
      case UP:
        decreaseFallOff();
      break;
      case DOWN:
        increaseFallOff();
      break;
    }
  }
}

void generateMap() {
  float xOffset = perlinOffset.x;
  for (int x = 0; x < mapSize; x++) {
    float yOffset = perlinOffset.y;
    for (int y = 0; y < mapSize; y++) {
      yOffset+= mapStep;
      heights[getHeightIndex(x, y)] = (int)map(noise(xOffset, yOffset), 0, 1, 0, maxHeight);
    }
    xOffset += mapStep;
  }
}

int getHeightIndex(int x, int y) {
  return x+(y*mapSize);
}

void drawMap() {
  pushMatrix();
  int mapStartCoord = -tileSize*mapSize/2;
  rotateX(-HALF_PI);
  int hue = (int)map(mouseY,0,height,0,340);
  translate(mapStartCoord,mapStartCoord,-maxHeight/2);
  for (int y = 0; y < mapSize-1; y++) {
    fill(hue+(y % 2)*10,80,80);
    drawMapStrip(y);
  }
  popMatrix();
}

void drawMapStrip(int y) {

  int yOffset = y*tileSize;
  int topCornerHeightIdx = getHeightIndex(0, y);
  int bottomCornerHeightIdx = getHeightIndex(0, y+1);
  int xOffset = 0;

  beginShape(QUAD_STRIP);
  for (int x = 0; x < mapSize; x++) {
    int tHeight = heights[topCornerHeightIdx];
    int bHeight = heights[bottomCornerHeightIdx];
    vertex(xOffset, yOffset, tHeight);
    vertex(xOffset, yOffset+tileSize, bHeight);
    xOffset += tileSize;
    topCornerHeightIdx++;
    bottomCornerHeightIdx++;
  }
  endShape();
}

void increaseLOD() {
  if (lod < 10) {
    lod++;
  }
}

void decreaseLOD() {
  if (lod > 1) {
    lod--;
  }
}

void increaseFallOff() {
  if (fallOff < 0.95) {
    fallOff += 0.1;
  }
}

void decreaseFallOff() {
  if (fallOff > 0.05) {
    fallOff -= 0.1;
  }
}