class Walker {
  float x;
  float y;
  int shade;
  float lastX, lastY;
  boolean reset;
  
  Walker() {
    x = width/2;
    y = height/2;
    reset = true;
    shade = int(random(0,360));
  }

  void display() {
    fill(shade,80,70);
    strokeWeight(1);
    stroke(shade,80,80);
    ellipse(x,y,3,3);
    
    if (reset) {
      reset = false;
    } else {
      line(lastX, lastY, x, y);
    }
  }

  void step() {
    float stepx = random(-8,8);
    float stepy = random(-8,8);
    
    lastX = x;
    lastY = y;
    
    x += stepx;
    y += stepy;
    
    if (y > height || x > width || x < 0 || y < 0) 
    {
      y = height/2;
      x = width/2;
      shade = (shade + 30) % 360;
      reset = true;
    }
  }
}