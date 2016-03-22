// Nature of Code - page 54

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topSpeed;
    
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0,0);
    topSpeed = 3;
  }
  
  void update() {
    acceleration = PVector.random2D();
    acceleration.mult(noise(location.x,location.y));
    
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(240);
    ellipse(location.x, location.y, 24, 24);
  }
  
  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}