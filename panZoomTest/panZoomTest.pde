ViewNavigator navigator;

void setup() {
  size(600, 600);
  navigator = new ViewNavigator();
  frameRate(60);
}

void draw() {
  navigator.HandleUserNavigation();

  background(80);
  drawStaticSketch();
}

void drawStaticSketch() {
  fill(0, 250, 250);
  stroke(255, 0, 0);
  rect(50, 50, 100, 100);
  rect(50, 450, 100, 100);
  rect(450, 50, 100, 100);
  rect(450, 450, 100, 100);
  noFill();
  rect(width/2-10, height/2-10, 20, 20);
  stroke(255);
  for (int i = 0; i < width; i+= 50) {
    for (int j = 0; j < height; j += 50) {
      point(i, j);
    }
  }
}

void mouseWheel(MouseEvent event) {
  navigator.StepZoom(event.getCount());
}

void mousePressed() {
  PVector coord = navigator.ViewToModelCoord(mouseX, mouseY);
  println("Mouse: ", mouseX, ",", mouseY);
  print("Zoom: ", navigator.base.scale);
  print(" Rot: ", degrees(navigator.base.rotation));
  println(" Tran: ", navigator.base.translation);
  println("Co-ord is: ", coord);
  coord = navigator.ModelToViewCoord(coord.x, coord.y);
  println("Reverse is: ", coord);
  if (abs(coord.x-mouseX) > 1 || abs(coord.y-mouseY) > 1) {
    println("Comparison not so good. :O");
  }
}

enum ViewMode {
  IDLE, 
    DRAGGING, 
    EASING
}

  enum DragOperation {
  NONE, 
    PAN, 
    ZOOM, 
    ROTATE
}