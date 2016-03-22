// Nature of Code - page 46

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topSpeed;
  int gear;
  
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0,0);
    acceleration = new PVector(random(-0.05,0.05), random(-0.05,0.05));
    topSpeed = 5;
    gear = 0;
  }
  
  void update() {
    if (keyPressed && key == CODED && keyCode == UP && gear < 50) {
      velocity.add(acceleration);
      ++gear;
    } else if (keyPressed && key == CODED && keyCode == DOWN && gear > 0) {
      velocity.sub(acceleration);
      --gear;
    }
    velocity.limit(topSpeed);
    location.add(velocity);
  }

  void display() {
    stroke(0);
    fill(240,240,0);
    ellipse(location.x, location.y, 16, 16);
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