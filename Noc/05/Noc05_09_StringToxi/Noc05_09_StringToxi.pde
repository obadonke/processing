import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.Iterator;

VerletPhysics2D physics;
ArrayList<Particle> particles;
ArrayList<Stringy> strings;

Particle activeTail;
Vec2D mouseOffset;

void setup() {
  size(640, 500);

  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));
  physics.setWorldBounds(new Rect(0, 0, width, height));

  strings = new ArrayList<Stringy>();
  strings.add(new Stringy(100, 50, 15, 15));
  strings.add(new Stringy(400, 50, 15, 20));
  strings.add(new Stringy(250, 50, 30, 10));
  strings.add(new Stringy(550, 50, 30, 8));
}

void draw() {
  physics.update();

  background(255);

  for (Stringy s : strings) {
    s.display();
  }
}

void mousePressed() {
  activeTail = null;
  println("MousePressed");

  for (Stringy s : strings) {
    if (hitParticle(s.getTail())) {
      activeTail = s.getTail();
      break;
    }
  }

  if (activeTail != null) {
    mouseOffset = new Vec2D(activeTail.x - mouseX, activeTail.y - mouseY);
    activeTail.lock();
  }
}

void mouseDragged() {
  if (activeTail == null) return;

  activeTail.set(mouseOffset.add(mouseX, mouseY));
}

void mouseReleased() {
  if (activeTail != null) {
    activeTail.unlock();
  } 

  activeTail = null;
}


boolean hitParticle(Particle s) {
  return abs(s.distanceTo(new Vec2D(mouseX, mouseY))) < s.getRadius()*2;
}