import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.Iterator;

VerletPhysics2D physics;
Cluster cluster;

void setup() {
  size(640, 800);
  
  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0, 0, width, height));
  
  cluster = new Cluster(20, 100, new Vec2D(width/2, height/2));
}

void draw() {
  physics.update();
  
  background(255);
  cluster.display();
}