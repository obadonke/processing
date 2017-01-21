import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import java.util.Iterator;

// Nature of Code Exercise 1.6 Acceleration using Perlin noise
// Now integrated with Box2D

int MAX_MOVERS = 30;
int totalPixels;

ArrayList<Mover> movers = new ArrayList<Mover>();

Box2DProcessing box2d;

void setup() {
  size(800, 800);
  background(250);
  totalPixels = width*height;
 
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,0);
  
  for (int i = 0; i < MAX_MOVERS; i++) {
    movers.add(new Mover());
  }
}
void draw() {
  fadeBackground();
  
  box2d.step();
  
  for (Mover mover: movers) {
    mover.update();
    mover.display();
  }
}

void fadeBackground() {
  loadPixels();
  for (int i = 0; i < totalPixels; i++) {
    int shade = pixels[i] >> 16 & 0xFF;
    if (shade < 180) shade += 1;
    if (shade > 220) shade -= 1;
    pixels[i] = color(shade,0,0);
  }
  updatePixels();
}