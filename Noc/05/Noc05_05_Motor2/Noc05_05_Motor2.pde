import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import java.util.Iterator;

// A list for all of our rectangles
ArrayList<IBox> boxes;
Platform platform;  // to catch strays
Bridge bridge;

Box2DProcessing box2d;    
Spring mouseSpring;

void setup() {
  size(800,600);
  smooth();
  // Initialize and create the Box2D world
  box2d = new Box2DProcessing(this);  
  box2d.createWorld();
  
  // Create ArrayLists
  boxes = new ArrayList<IBox>();
  platform = new Platform(width/2, height, width*.9, 6);

  bridge = new Bridge(height/3, 8, 8); //<>//
  mouseSpring = new Spring();
}

void draw() {
  background(255);
  platform.display();
  bridge.display();
  
  mouseSpring.update(mouseX, mouseY);
  
  // We must always step through time!
  box2d.step();    

  // When the mouse is clicked, add a new Box object
  if (mousePressed && mouseButton == RIGHT) {
    BoxWithTail p = new BoxWithTail(mouseX,mouseY);
    boxes.add(p);
  }

  // Display all the boxes
  Iterator<IBox> boxIter = boxes.iterator();
  while (boxIter.hasNext()) {
    IBox b = boxIter.next();
    if (b.isDead()) {
      boxIter.remove();
      continue;
    }
    b.display();
  }
  
  mouseSpring.display();
}

void mousePressed() {
  if (mouseButton != LEFT) return;
  
  // find an object to bind
  for (IBox box: boxes) {
    if (box.contains(mouseX, mouseY)) {
      mouseSpring.bind(box.getBody(), mouseX, mouseY);
      return;
    }
  }
}

void mouseReleased() {
  mouseSpring.unbind();
}