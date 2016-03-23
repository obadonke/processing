// Nature of Code - Exercise 2.1 - Page 70
class Balloon extends Mover {
  PVector heliumForce = new PVector(0, -random(0.01,0.06));
  Balloon() {
    super();

    // start somewhere along bottom row of screen
    location = new PVector(random(0,width), height);
    
  }
  
  void update() {
    applyForce(heliumForce);
    super.update();
  }
}