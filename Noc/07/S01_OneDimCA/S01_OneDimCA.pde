
int[] cells = {1,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1,1,1,0,0};
int[] ruleset = {0,1,0,1,1,0,1,0};

float cellSize;
float nextCellY;
color deadColor = 255;
color aliveColor = color(240,0,0);

void setup() {
  size(800, 800);
  cellSize = width/cells.length;  
  nextCellY = 0;
  ruleset = byteToRuleset(2);
}

void draw() {
  if (nextCellY >= height)
    return;

  for (int i = 0; i < cells.length; i++) {
    fill(cells[i] == 0 ? deadColor: aliveColor);
    stroke(0);
    rect(i*cellSize, nextCellY, cellSize, cellSize);
  }
  
  iterateCells();
  nextCellY += cellSize;
}

void iterateCells() {
  
  int[] newCells = new int[cells.length];
  
  for (int i = 1; i < cells.length-1; i++) {
    int left = cells[i-1];
    int middle = cells[i];
    int right = cells[i+1];
    
    int newstate = rules(left,middle,right);
    newCells[i] = newstate;
  }
  
  cells = newCells;
}

int rules(int left, int mid, int right) {
  return ruleset[left*4 + mid*2 + right];
}

int[] byteToRuleset(int b) {
  int bit = 1;
  
  int[] ruleSet = new int[8];
  for (int i = 0; i < 8; i++) {
    ruleSet[i] = (b & bit) > 0 ? 1 : 0;
    bit = bit<<1;
  }
  
  return ruleSet;
}