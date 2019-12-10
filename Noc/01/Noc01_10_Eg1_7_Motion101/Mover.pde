// Nature of Code - page 46
import java.util.Random;

class Mover {
  PVector location;
  PVector velocity;
  int size;
  Random rand;
  
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = PVector.random2D().mult(0.5+random(2));
    rand = new Random();
    size = 16+(int)(rand.nextGaussian()*2);
  }
  
  void update() {
    location.add(velocity);
  }

  void display() {
    stroke(10,10,100);
    fill(240,240,0);
    ellipse(location.x, location.y, size, size);
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