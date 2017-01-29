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

  clusters = new ArrayList<Cluster>();
  clusters.add(new Cluster(20, 100, new Vec2D(width/2, height/2)));
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
  println("MousePressed");

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