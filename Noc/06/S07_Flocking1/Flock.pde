class Flock {
  ArrayList<Boid> boids = new ArrayList<Boid>();
  Path path;
  ArrayList<WeightedBehaviour> behaviours = new ArrayList<WeightedBehaviour>();
  SeparationBehaviour separationBehaviour = new SeparationBehaviour(boids);

  Flock(int numBoids, Path path) {
    this.path = path;

    ITarget target = new MouseTarget();
    SeekBehaviour seekBehaviour = new SeekBehaviour(target, BoidParams.MAX_SPEED);
    behaviours.add(new WeightedBehaviour(seekBehaviour,1.0));
    target = new PathTarget(path);
    SeekBehaviour pathSeekBehaviour = new SeekBehaviour(target, BoidParams.MAX_SPEED);
    behaviours.add(new WeightedBehaviour(pathSeekBehaviour,0.5));
    behaviours.add(new WeightedBehaviour(separationBehaviour,2));

    for (int i = 0; i < numBoids; i++) {
      Boid v = new Boid(random(width), random(height), 5, behaviours);
      boids.add(v);
    }
  }

  void flap() {
    if (DRAW_PATH) path.display();

    for (Boid v : boids) {
      v.applyBehaviours();
      v.update();
      if (DIAGNOSTIC_MODE) {
        v.debugDisplay();
      }
      v.checkEdges();
      v.display();
    }
  }
}

