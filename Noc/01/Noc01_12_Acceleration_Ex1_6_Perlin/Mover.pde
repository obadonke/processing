// Nature of Code - page 54

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topSpeed;
  float noiseOffset;
  
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0,0);
    topSpeed = 2;
    noiseOffset = random(10000);
  }
  
  void update() {
    acceleration = new PVector(noise2scalar(noiseOffset),noise2scalar(noiseOffset+1000));
    noiseOffset+=0.01;
    
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);
  }

  float noise2scalar(float offset) {
    return map(noise(offset),0,1,-0.1,0.1);
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