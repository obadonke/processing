import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.Iterator;

VerletPhysics2D physics;
ArrayList<Particle> particles;
Cloth cloth;

Particle activeParticle;
Vec2D mouseOffset;

void setup() {
  size(640, 800);

  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));
  physics.setWorldBounds(new Rect(0, 0, width, height));

  cloth = new Cloth(100,0,400,400,40,40,6,0.2);
}

void draw() {
  physics.update();

  background(255);

  cloth.display();
}

void mousePressed() {
  activeParticle = null;
  println("MousePressed");

  for (Particle p: cloth.getHooks()) {
    if (hitParticle(p)) {
      activeParticle = p;
      break;
    }
  }

  if (activeParticle != null) {
    mouseOffset = new Vec2D(activeParticle.x - mouseX, activeParticle.y - mouseY);
    activeParticle.lock();
  }
}

void mouseDragged() {
  if (activeParticle == null) return;

  activeParticle.set(mouseOffset.add(mouseX, mouseY));
}

void mouseReleased() {
  if (activeParticle != null) {
    activeParticle.unlock();
  } 

  activeParticle = null;
}


boolean hitParticle(Particle s) {
  return abs(s.distanceTo(new Vec2D(mouseX, mouseY))) < s.getRadius()*2;
}