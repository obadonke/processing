import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.Iterator;

VerletPhysics2D physics;
ArrayList<Cluster> clusters;
Node activeNode;
Vec2D mouseOffset;
Attractor attractor;

void setup() {
  size(640, 800);

  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0, 0, width, height));
  //physics.addBehavior(new GravityBehavior2D(new Vec2D(0.0,0.1)));
  physics.setDrag(0.05);
  
  attractor = new Attractor(999, new Vec2D(width/2, height/2), 200, 0.2);
  
  clusters = new ArrayList<Cluster>();
  clusters.add(new Cluster(21, 100, new Vec2D(2*width/3, height/2)));
  clusters.add(new Cluster(10, 80, new Vec2D(width/3, height*2/3)));
  clusters.add(new Cluster(5, 50, new Vec2D(width/2, height/4)));
  clusters.add(new Cluster(15, 120, new Vec2D(3*width/4, height/4)));
  
  connectClusters(clusters.get(0),clusters.get(1),250);
  connectClusters(clusters.get(0),clusters.get(2),150);
  connectClusters(clusters.get(1),clusters.get(2),200);
  connectClusters(clusters.get(0),clusters.get(3),400);
}

void draw() {
  physics.update();

  background(255);

  attractor.display();
  
  for (Cluster c : clusters) {
    c.display();
  }
}

void mousePressed() {
  activeNode = null;

  for (Cluster c : clusters) {
    Node n = c.getHeadNode();
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

void connectClusters(Cluster c1, Cluster c2, int distance) {
  Node n1 = c1.getHeadNode();
  
  Node n2 = c2.getHeadNode();
  
  VerletSpring2D spring = new VerletMinDistanceSpring2D(n1, n2, distance, 1);
  physics.addSpring(spring);
}