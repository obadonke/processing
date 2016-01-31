import java.util.Random;

Random generator = new Random();
float stepMean = 2;
float stepStdDev = 1;

class Walker {
  float x;
  float y;
  PVector direction = new PVector();
  
  Walker() {
    x = width/2;
    y = height/2;
  }

  void display() {
    fill(0);
    ellipse(x,y,3,3);
  }

  void step() {
    setDirection();
    
    direction.setMag(stepMean+ abs((float)generator.nextGaussian())*stepStdDev);
    
    x += direction.x;
    y += direction.y;
  }
  
  void setDirection() {
    // decide a direction. 50% chance of moving towards mouse.
    direction.x = (x < mouseX) ? 1 : -1;
    direction.y = (y < mouseY) ? 1 : -1;
       
    float choice = random(0,1);
    if (choice < 0.30) {
      direction.x = -direction.x;
      direction.y = -direction.y;
    }
    else if (choice < 0.4) {
      direction.x = -direction.x;
    }
    else if (choice < 0.5) {
      direction.y = -direction.y;
    }
  }
  
}