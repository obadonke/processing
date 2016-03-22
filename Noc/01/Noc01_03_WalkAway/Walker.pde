class Walker {
  int x;
  int y;
  int stepX;
  int stepY;
  
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
    
    x += stepX*2;
    y += stepY*2;
  }
  
  void setDirection() {
    // decide a direction. 50% chance of moving towards mouse.
    stepX = (x < mouseX) ? 1 : -1;
    stepY = (y < mouseY) ? 1 : -1;
       
    float choice = random(0,1);
    if (choice < 0.30) {
      stepX = -stepX;
      stepY = -stepY;
    }
    else if (choice < 0.4) {
      stepX = -stepX;
    }
    else if (choice < 0.5) {
      stepY = -stepY;
    }
  }
  
}