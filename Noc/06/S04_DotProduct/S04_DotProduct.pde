PVector vectorA;
PVector vectorB;
float vectorLength = min(width/3, height/3);

void setup() {
  size(640,640);
  vectorLength = min(width/3, height/3);
  createNewVectors();
}

void draw() {
  background(0);
  fill(255);
  stroke(255);
  textSize(26);
  textAlign(CENTER, CENTER);
  
  pushMatrix();
  translate(width/2,10+height/3);
  drawVector(vectorA, "A");
  drawVector(vectorB, "B");
  popMatrix();
  
  float dot = vectorA.dot(vectorB);
  float angle = acos(dot/(vectorLength*vectorLength));
  float angleBetween = PVector.angleBetween(vectorA,vectorB);
  pushMatrix();
  translate(width/2, height*0.8);
  text("Angle is " + angle + " radians.",0,0);
  text(degrees(angle) + " degrees.",0,30);
  text("Anglebetween says " + degrees(angleBetween) + " degrees.",0,60);
  popMatrix();
}

void mouseReleased() {
  createNewVectors();
}

void createNewVectors() {
  vectorA = PVector.random2D();
  vectorA.setMag(vectorLength);
  vectorB = PVector.random2D();
  vectorB.setMag(vectorLength);
}

void drawVector(PVector vector, String label) {
  line(0,0, vector.x, vector.y);
  text(label, vector.x/2, vector.y/2);
  pushMatrix();
  translate(vector.x, vector. y);
  rotate(vector.heading());
  beginShape();
  vertex(0,0);
  vertex(-10,4);
  vertex(-10,-4);
  endShape(CLOSE);
  popMatrix();
}