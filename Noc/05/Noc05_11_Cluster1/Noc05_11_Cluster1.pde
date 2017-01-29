import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.Iterator;

VerletPhysics2D physics;
ArrayList<Cluster> clusters;
Node activeNode;
Vec2D mouseOffset;

void setup() {
  size(640, 800);

  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0, 0, width, height));
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0.0,0.01)));
  
  clusters = new ArrayList<Cluster>();
  clusters.add(new Cluster(20, 100, new Vec2D(2*width/3, height/2), physics));
  clusters.add(new Cluster(10, 80, new Vec2D(width/3, height*2/3), physics));
  clusters.add(new Cluster(5, 50, new Vec2D(width/2, height/4), physics));
}

void draw() {
  physics.update();

  background(255);

  for (Cluster c : clusters) {
    c.display();
  }
}

void mousePressed() {
  activeNode = null;

  for (Cluster c : clusters) {
    Node n = c.getPinNode();
    if (hitNode(n)) {
      activeNode = n;
      break;
    }
  }

  if (activeNode != null) {
    mouseOffset = new Vec2D(activeNode.x - mouseX, activeNode.y - mouseY);
    activeNode.lock();
  }
}

void mouseDragged() {
  if (activeNode == null) return;

  activeNode.set(mouseOffset.add(mouseX, mouseY));
}

void mouseReleased() {
  if (activeNode != null) {
    activeNode.unlock();
  } 

  activeNode = null;
}


boolean hitNode(Node n) {
  return abs(n.distanceTo(new Vec2D(mouseX, mouseY))) < n.getRadius()*2;
}