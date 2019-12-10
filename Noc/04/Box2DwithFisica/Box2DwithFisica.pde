import fisica.*;

// trying with fisica. 
// first impressions: Fisica adds a significant wrapper around Box2D.
// You use it in a simplified way compared to the underlying Box2D library.
// Hence own learning curve but likely easier to appy for Processing use
// once you've learnt it.

FWorld world;
FBox boxX;

void setup() {
  size(600,600);
  frameRate(60);
  Fisica.init(this);
  
  world = new FWorld();
  world.setEdges();
  //world.setGravity(0,10);
  
  FCircle box = new FCircle(100);
  box.setPosition(300,300);
  //box.setStatic(true);
  world.add(box);
  
  FBox box2 = new FBox(75,75);
  box2.setPosition(270,210);
  //box2.addImpulse(10000,0);
  box2.setAngularVelocity(-PI);
  world.add(box2);
  boxX = box2;
  
  FBox box3 = new FBox(50,50);
  box3.setPosition(305,155);
  box3.setBullet(true);
  world.add(box3);
}

void draw() {
  background(128);
  world.step();
  //boxX.addForce(500,0);
  world.draw();
}