void setup() 
{
  size(800,800);
}

void draw()
{
  DrawHex(mouseX,mouseY,50,true);
}

void DrawHex(float x,float y,float radius,boolean isVert)
{
  float w = abs(radius * cos(radians(60)));
  float h = abs(radius * sin(radians(60)));
  
  translate(x,y);
  if (isVert) {
    rotate(HALF_PI);
  }
  
  beginShape();
  vertex(-radius,0);
  vertex(-w,-h);
  vertex(w,-h);
  vertex(radius,0);
  vertex(w,h);
  vertex(-w,h);
  endShape(CLOSE);
  translate(-x,-y);
}

