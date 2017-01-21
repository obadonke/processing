// Astroid thingy based on Nature of Code chapter 3
// Now with added Box2D
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
//import java.util.Iterator;

Box2DProcessing box2d;
Lander lander;
Platform platform1;
Platform platform2;

void setup() {
  size(800, 600);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  //box2d.setGravity(0,0);

  lander = new Lander(new PVector(width/4, height/2));
  
  platform1 = new Platform(200, 500, 400, 10);
  platform2 = new Platform(width-200, 200, 200, 10);
}

void draw() {
  background(255);
  box2d.step();
  
  platform1.display();
  platform2.display();
  lander.update();
  lander.draw();
}


void keyPressed() {
  if (key == 'A' || key == 'a') {
    lander.leftThrust(true);
  } else if (key == 'D' || key == 'd') {
    lander.rightThrust(true);
  }
}

void keyReleased() {
  if (key == 'A' || key == 'a') {
    lander.leftThrust(false);
  } else if (key == 'D' || key == 'd') {
    lander.rightThrust(false);
  }
}