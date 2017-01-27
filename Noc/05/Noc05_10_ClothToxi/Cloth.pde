class Cloth {
  int numParticlesX;
  int numParticlesY;
  Particle[][] particles;
  ArrayList<Particle> hooks;
  SegmentDrawer drawer;
  SegmentSpringMaker springMaker;
  
  Cloth(float left, float top, float w, float h, int xSegments, int ySegments, int numPins, float strength) {
    numParticlesX = xSegments+1;
    numParticlesY = ySegments+1;
    if (numPins < 2) numPins = 2;
    
    particles = new Particle[numParticlesX][numParticlesY];
    float segWidth = w/xSegments;
    float segHeight = h/ySegments;
    println("SegWxH " + segWidth + " x " + segHeight);
    float restLen = min(segWidth, segHeight);
    springMaker = new SegmentSpringMaker(restLen, strength);
    drawer = new SegmentDrawer(restLen);

    for (int i = 0; i < numParticlesX; i++) {
      float x = left + segWidth*i;
      for (int j = 0; j < numParticlesY; j++) {
        float y = top + segWidth*j;

        Particle p = new Particle(new Vec2D(x, y));
        particles[i][j] = p;
        physics.addParticle(p);
      }
    }

    hooks = new ArrayList<Particle>();

    particles[0][0].lock();
    hooks.add(particles[0][numParticlesY-1]);
    for (int i = 0; i < numPins; i++) {
      int pinX = (numParticlesX*(i+1)/numPins)-1;
      particles[pinX][0].lock();
      hooks.add(particles[pinX][numParticlesY-1]);
    }
    
    applySegmentFunc(springMaker);
  }

  ArrayList<Particle> getHooks() {
    return hooks;
  }

  void display() {
    strokeWeight(1.5);
    applySegmentFunc(drawer);
    
    for (Particle p: hooks) {
      p.display();
    }
  }
  
  void applySegmentFunc(ISegmentFunc func) {
    int i, j;
    for (i = 0; i < numParticlesX; i++) {
      Particle prev = particles[i][0];
      for (j = 1; j < numParticlesY; j++) {
        Particle next = particles[i][j];
        func.DoSegment(prev, next);
        prev = next;
      }
    }
    for (j = 0; j < numParticlesY; j++) {
      Particle prev = particles[0][j];
      for (i = 1; i < numParticlesX; i++) {
        Particle next = particles[i][j];
        func.DoSegment(prev, next);
        prev = next;
      }
    }

  }
}