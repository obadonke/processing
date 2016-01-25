// color wheel
int wheelRadius = 150;
int wheelDiameter = wheelRadius*2;
int gradientBoxStart = wheelDiameter+5;
int gradientBoxSize = wheelDiameter;

int wheelCenterRadius = 50;
color backColor = color(20);
PImage colorWheel = null;
int hueSelected;

void setup() {
  colorMode(HSB, 360, 100, 100);
}

void settings() {
  size(gradientBoxStart+gradientBoxSize, wheelDiameter);
}

void draw() {
  background(backColor);
  setHueFromMouse();
  drawHueGradients(); 

  if (colorWheel == null)
  {
    drawColorWheel();
    colorWheel = get(0,0,wheelDiameter,wheelDiameter);
  }
  
  image(colorWheel,0,0);
  
  if (hueSelected != -1) {
    fill(hueSelected,100,100);
    int spotSize = int(wheelCenterRadius*1.5);
    ellipse(wheelRadius,wheelRadius,spotSize,spotSize);
    fill(0);
    textAlign(CENTER,CENTER);
    textSize(spotSize/3);
    text(str(hueSelected), wheelRadius,wheelRadius);
  }
}

void drawColorWheel() {
  strokeWeight(4);
  pushMatrix();
  translate(wheelRadius, 0);
  for (float angle = 0; angle < 360; angle+= 1) {
    for (int radius = wheelCenterRadius; radius < wheelRadius; radius += 2) {
      int x = int(cos(radians(angle))*radius);
      int y = wheelRadius - int(sin(radians(angle))*radius);
      int z = int(map(radius, 0, wheelRadius, 100, 1));

      stroke(int(angle), 100, 100);
      point(x, y);
    }
  }
  popMatrix();
}

void drawHueGradients() {
  if (hueSelected == -1) return;

  int gradientSize = int(gradientBoxSize*.9);
  strokeWeight(4);

  for (int s = 0; s < 100; s++)
  {

    float x = map(s, 0, 100, 0, gradientSize);
    for (int b = 0; b < 100; b++) {

      float y = map(b, 0, 100, 0, gradientSize);

      // vertical - brightness
      stroke(hueSelected, s, b);
      point(x+gradientBoxStart, y);
    }

    // draw pure gradients on the outside
    stroke(hueSelected, 100, s);
    line(gradientBoxStart+gradientSize+3, x, gradientBoxStart+gradientBoxSize, x);
    stroke(hueSelected, s, 100);
    line(gradientBoxStart+x, gradientSize+3, gradientBoxStart+x, wheelDiameter);
  }
}

void setHueFromMouse() {
  int newHue = hueFromMouse();
  
  if (newHue != -1) hueSelected = newHue;
}

int hueFromMouse() {
  // which hue is under the cursor?
  // if mouse is outside the wheel, return -1

  float radius = dist(mouseX, mouseY, wheelRadius, wheelRadius); //<>//
  if (radius < wheelCenterRadius || radius > wheelRadius) return -1;

  float x = mouseX-wheelRadius;
  float y = -(mouseY-wheelRadius);  
  int angle = int(degrees(atan2(y, x)));

  if (angle < 0) angle+= 360;
  return angle;
}