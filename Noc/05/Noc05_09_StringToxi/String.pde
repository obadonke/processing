class Stringy {
  ArrayList<Particle> particles;
  Particle tail;
  
  Stringy(int topX, int topY, int segments, int segLength) {
    particles = new ArrayList<Particle>();

    int x = topX;
    int y = topY;
    for (int i = 0; i < segments; i++) {
      Particle p = new Particle(new Vec2D(x, y));
      y += segLength;

      particles.add(p);
      physics.addParticle(p);
    }
    
    Iterator<Particle> iter = particles.iterator();
    Particle prev = iter.next();
    
    // lock the head node
    prev.lock();
    while (iter.hasNext()) {
      Particle next = iter.next();
      VerletSpring2D spring = new VerletSpring2D(prev, next, segLength, 0.3);
      physics.addSpring(spring);
      
      prev = next;
    }
    
    // store the tail node
    tail = prev;
  }
  
  void display() {
    noFill();
    strokeWeight(2);
    beginShape();
    for (Particle p: particles) {
      vertex(p.x, p.y);
    }
    endShape();
    
    tail.display();
  }
  
  Particle getTail() {
    return tail;
  }
}