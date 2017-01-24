import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;
Particle p1;
Particle p2;

void setup() {
  size(640, 360);
  
  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));
  physics.setWorldBounds(new Rect(0, 0, width, height));
  
  p1 = new Particle(new Vec2D(100, 20));
  p2 = new Particle(new Vec2D(100, 180));
  p1.lock();
  physics.addParticle(p1);
  physics.addParticle(p2);
  
  VerletSpring2D spring=new VerletSpring2D(p1, p2, 80, 0.01);
  physics.addSpring(spring);
}

void draw() {
  physics.update();
  
  background(255);
  
  line(p1.x,p1.y, p2.x, p2.y);
  p1.display();
  p2.display();
  
  if (mousePressed) {
    p2.lock();
    p2.x = mouseX;
    p2.y = mouseY;
    p2.unlock();
  }
}