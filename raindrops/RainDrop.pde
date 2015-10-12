//-----------------------------------------------

class RainDrop
{
  int x;
  float y;
  float speed;
  int size;
  color dropColor;
  
  RainDrop(int x)
  {
    this.x = x;
    this.y = 0;
    this.speed = random(0.5,MAX_DROP_SPEED);
    this.size = int(random(2, MAX_DROP_SIZE));
    int hue = int(random(HUE_START,HUE_START+HUE_RANGE));
    this.dropColor = color(hue,SATURATION,BRIGHTNESS,ALPHA_VALUE);
  }

  void draw()
  {
    strokeWeight(this.size);
    stroke(dropColor);
    point(x, y);
  }
  
  void update()
  {
    if (y < height+size)
    {
      this.y += this.speed;
      draw();
    }
  }
}

