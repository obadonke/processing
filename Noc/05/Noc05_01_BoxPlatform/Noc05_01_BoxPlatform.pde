import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import java.util.Iterator;

// A list for all of our rectangles
ArrayList<Box> boxes;
Platform platform1, platform2;

Box2DProcessing box2d;    

void setup() {
  size(400,300);
  smooth();
  // Initialize and create the Box2D world
  box2d = new Box2DProcessing(this);  
  box2d.createWorld();
  
  // Create ArrayLists
  boxes = new ArrayList<Box>();
  platform1 = new Platform(width/2, height, width*.8, 6);
  platform2 = new Platform(width*3/4, height/2, width*.2, 6);
}

void draw() {
  background(255);
  platform1.display();
  platform2.display();
  
  // We must always step through time!
  box2d.step();    

  // When the mouse is clicked, add a new Box object
  if (mousePressed) {
    Box p = new Box(mouseX,mouseY);
    boxes.add(p);
  }

  // Display all the boxes
  Iterator<Box> boxIter = boxes.iterator();
  while (boxIter.hasNext()) {
    Box b = boxIter.next();
    if (b.isDead()) {
      boxIter.remove();
      continue;
    }
    b.display();
  }
}