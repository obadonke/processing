final int FIELD_SIZE = 50;
final int NUM_FIELDS = 16;

void setup() {
  size(800, 800);

  if (FIELD_SIZE*NUM_FIELDS <= width || FIELD_SIZE*NUM_FIELDS <= height) {
    println("Make sure width and height are at least " + FIELD_SIZE*NUM_FIELDS + " pixels.");
  }
}

void draw() {
  ellipse(400,400,80,80);
}