class FlowField {
  PVector[][] field;

  int cols, rows;
  int resolution;
  float noiseOffset;
  final float noiseScale = FIELD_NOISE_SCALE;
  int cellWidth;
  int cellHeight;

  FlowField(int resolution) {
    this.resolution = resolution;

    cols = width/resolution;
    rows = height/resolution;

    noiseOffset = 0;
    field = new PVector[cols][rows];
    populateField();
  }

  private void populateField() {
    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        field[c][r] = chooseFieldVector(c, r);
      }
    }
  }

  void shiftField(float amount) {
    noiseOffset += amount;
    populateField();
  }

  PVector getFieldVectorAt(float x, float y) {
    int c = constrain((int)x/resolution, 0, cols-1);
    int r = constrain((int)y/resolution, 0, rows-1);
    return field[c][r].copy();
  }

  void display() {
    float cellWidth = resolution;
    float cellHeight = resolution;

    strokeWeight(0.5);
    stroke(100);
    for (int r = 0; r < rows; r++) {
      float y = r*cellHeight;
      line(0, y, width, y);
    }

    for (int c = 0; c < cols; ++c) {
      float x = c*cellWidth;

      stroke(100);
      line(x, 0, x, height);

      for (int r = 0; r < rows; ++r) {
        float y = r*cellHeight;
        float midY = y+cellHeight/2.0;
        float midX = x+cellWidth/2.0;
        float halfArrowLength = min(cellHeight, cellWidth)*0.4;
        drawFlowArrow(midX, midY, halfArrowLength, field[c][r]);
      }
    }
  }

  private PVector chooseFieldVector(int c, int r) {
    float noiseVal = noise(c*noiseScale + noiseOffset, r*noiseScale + noiseOffset);
    noiseVal = map(noiseVal, 0, 1, 0, TWO_PI);
    return new PVector(cos(noiseVal), sin(noiseVal));
  }


  private void drawFlowArrow(float centerX, float centerY, float halfArrowLength, PVector arrowVector) {
    pushMatrix();
    translate(centerX, centerY);
    rotate(arrowVector.heading());
    line(-halfArrowLength, 0, halfArrowLength, 0);
    line(halfArrowLength/2, halfArrowLength/2, halfArrowLength, 0);
    line(halfArrowLength/2, -halfArrowLength/2, halfArrowLength, 0);
    popMatrix();
  }
}