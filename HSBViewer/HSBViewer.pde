PImage img;
public enum ColorMode { 
  COLOR, HUE, SATURATION, BRIGHTNESS
}
  ColorMode mode = ColorMode.COLOR;

void setup() {

  colorMode(HSB, 360, 100, 100);
  img = loadImage("image.jpg");
  size(img.width, img.height);
  println("Image width: " + str(img.width) + " Height: " + str(img.height));
}

void draw() {
  image(img, 0, 0);
  String caption = getColorModeText();
  textSize(20);
  text(caption, 0, 20);

  if (mode == ColorMode.COLOR)
    return;


  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color pxl = get(x, y);
      float h = hue(pxl);
      float sat = saturation(pxl);
      float bright = brightness(pxl);

      float brightAdjustment = 1-pow((100-bright)/100, 3);

      if (mode == ColorMode.SATURATION) {
        if (x < mouseX) {
          set(x, y, color(h, 0, sat));
        } else {
          set(x, y, color(h, 0, sat*brightAdjustment));
        }
      } else if (mode == ColorMode.BRIGHTNESS) {
        set(x, y, color(0, 0, bright));
      } else if (sat < 2) {
        set(x, y, color(h, sat, bright));
      } else {
        if (x < mouseX) {
          set(x, y, color(h, 100, 100*brightAdjustment));
        } else {
          set(x, y, color(h, 100, 100));
        }
      }
    }
  }
  text(caption, 0, 20);
}

String getColorModeText() {
  switch (mode) {
  case HUE:
    return "Hue";
  case SATURATION:
    return "Saturation w/Brightness adjust";
  case BRIGHTNESS:
    return "Brightness";
  case COLOR:
  default:
    return "Color";
  }
}

void keyPressed() {
  switch (key) {
  case 'H': case 'h':
    mode = ColorMode.HUE;
    break;
  case 'B': case 'b':
    mode = ColorMode.BRIGHTNESS;
    break;
  case 'S': case 's':
    mode = ColorMode.SATURATION;
    break;
  }
}

void keyReleased() {
  mode = ColorMode.COLOR;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    mode = ColorMode.HUE;
  } else if (mouseButton == RIGHT) {
    mode = ColorMode.SATURATION;
  } else {
    mode = ColorMode.BRIGHTNESS;
  }
}


void mouseReleased() {
  mode = ColorMode.COLOR;
}