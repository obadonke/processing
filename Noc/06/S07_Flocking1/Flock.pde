class Flock {
  ArrayList<Boid> boids = new ArrayList<Boid>();
  Path path;
  ArrayList<WeightedBehaviour> behaviours = new ArrayList<WeightedBehaviour>();

  Flock(int numBoids, Path path) {
    this.path = path;

    ITarget target = new WanderTarget();
    SeekBehaviour seekBehaviour = new SeekBehaviour(target, BoidParams.MAX_SPEED);
    behaviours.add(new WeightedBehaviour(seekBehaviour, new SineFactor(580, 1, 5)));
    target = new PathTarget(path);
    SeekBehaviour pathSeekBehaviour = new SeekBehaviour(target, BoidParams.MAX_SPEED);
    behaviours.add(new WeightedBehaviour(pathSeekBehaviour, new SineFactor(1080, -0.5, 2)));

    SeparationBehaviour separationBehaviour = new SeparationBehaviour(boids);
    behaviours.add(new WeightedBehaviour(separationBehaviour, new SineFactor(100, 0.5, 2)));

    AlignBehaviour align = new AlignBehaviour(boids);
    behaviours.add(new WeightedBehaviour(align, new ConstantFactor(1)));
       
    CohesionBehaviour cohesion = new CohesionBehaviour(boids, BoidParams.MAX_SPEED);
    behaviours.add(new WeightedBehaviour(cohesion, new SineFactor(720, -0.1, 1)));

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