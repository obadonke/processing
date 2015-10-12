void setup()
{
  size(600, 400, P3D);
}

void draw()
{
  background(60, 42, 67);
  fill(200, 0, 0);

  float stepAngle = 0; //frameCount*PI/180;
  float distToCamera = 580 + sin(stepAngle*2)*500;
  camera(0, 0, distToCamera, 0, 0, 0, 0, 1, 0);
  perspective(radians(45), width/height, distToCamera/10.0, distToCamera*10);
  for (int i = 0; i < 3; i++) {
    if (i == 0)
    {
      drawBoxRow(stepAngle+i);
    } else
    {
      pushMatrix();
      translate(0, 100*i, -150*i);
      drawBoxRow(stepAngle+i);  
      popMatrix();
      pushMatrix();
      translate(0, -100*i, -150*i);
      drawBoxRow(stepAngle+i);
      popMatrix();
    }
  }
}

void drawBoxRow(float angle)
{
  drawBox(0, angle,angle,0);
  drawBox(100, angle,angle*2,0);
  drawBox(200, angle*1.5, angle, 0);
  drawBox(-100, 0, angle, angle);
  drawBox(-200, angle, 0, angle*2.4);
}

void drawBox(float trX, float rotX, float rotY, float rotZ)
{
  fill(color(200,128+int(trX),0));
  pushMatrix();
  translate(trX,0,0);
  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);
  box(50);
  popMatrix();
}