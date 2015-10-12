// Sine and Cosine waves
float step = PI/30;

void setup() {
  size(800, 400);
  println("Sin(0) = " + str(sin(0)));
}

void draw() {
  background(80);
  translate(mouseX, 0);

  stroke(128);
  strokeWeight(1);
  line(0, 0, 0, height);
  line(-width*2, height/2, width*2, height/2);
  textSize(14);
  fill(255,0,0);
  text("Red = sin",10,height/2);
  fill(0,255,255);
  text("Cyan = cos",10+width/4,height/2);
  
  strokeWeight(10); //<>//
  for (float angle = -TWO_PI*2; angle < TWO_PI*2; angle += step) {
    int x = int(map(angle, -TWO_PI*2, TWO_PI*2, -width*2, width*2));
    float sine = sin(angle);
    float cosine = cos(angle);

    int siny = int(map(sine, -1, 1, height, 0));
    stroke(255, 0, 0);
    point(x, siny);

    int cosy = int(map(cosine, -1, 1, height, 0));
    stroke(0, 255, 255);
    point(x, cosy);
  }
}