// Astroid thingy based on Nature of Code chapter 3
// Now with added Box2D
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;
import java.util.Iterator;
import processing.sound.*;

Box2DProcessing box2d;
Lander lander;
ArrayList<Platform> platforms;
ArrayList<Box> boxes;
SoundFile ploppSound;

void setup() {
  size(800, 600);
  
  ploppSound = new SoundFile(this, "plopp.mp3");
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -2);
  box2d.listenForCollisions();
  
  lander = new Lander(new PVector(width/4, height/2));
  
  platforms = new ArrayList<Platform>();
  platforms.add(new Platform(200, 500, 400, 10));
  platforms.add(new Platform(width-200, 200, 200, 10));
  platforms.add(new Platform(0, height/2, 1, height));
  platforms.add(new Platform(width, height/2, 1, height));
  platforms.add(new Platform(width/2, height, width, 1));
  platforms.add(new Platform(width/2, 0, width, 1));

  boxes = new ArrayList<Box>();
  for (int i = 1; i < 25; i++) {
    boxes.add(new Box(i*width/25, 0, 10, 10, color(200, 0, 200)));
    
  }
}

void draw() {
  background(255);
  box2d.step();

  for (Platform platform : platforms) {
    platform.display();
  }

  Iterator<Box> iterBox = boxes.iterator();
  while (iterBox.hasNext()) {
    Box box = iterBox.next();
    if (box.isDead()) {
      iterBox.remove();
    } else {
      box.display();
    }
  }

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

void beginContact(Contact contact) {
  Object fixA = contact.getFixtureA().getBody().getUserData();
  Object fixB = contact.getFixtureB().getBody().getUserData();
  
  IContactable conA = IContactable.class.isInstance(fixA) ? (IContactable)fixA : null;
  IContactable conB = IContactable.class.isInstance(fixB) ? (IContactable)fixB : null;
  
  if (conA != null) {
    conA.madeContact(conB);
  }
  
  if (conB != null) {
    conB.madeContact(conA);
  }
}

public static boolean implementsInterface(Object object, Class interf){
    return interf.isInstance(object);
}

void endContact(Contact contact) {
  // must include this for contacts to work
}