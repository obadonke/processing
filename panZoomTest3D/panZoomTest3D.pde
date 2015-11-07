ViewNavigator navigator = new ViewNavigator();
float distToCamera = 250;
float CURSOR_SIZE = 25;

CameraPosition cameraPos = new CameraPosition(distToCamera);

void setup()
{
  size(640, 480, P3D);
}

void draw()
{
  background(60, 42, 67);
  fill(200, 0, 0);

  navigator.HandleUserNavigation(cameraPos);
  PVector eyePos = cameraPos.getEyePos();
  PVector lookAt = cameraPos.getLookAt();
  PVector up = cameraPos.getUp();
  
  camera(eyePos.x, eyePos.y, eyePos.z, lookAt.x, lookAt.y, lookAt.z, up.x, up.y, up.z);
  perspective();
  
  drawScene(0);
  drawCursor(lookAt);
}

void drawScene(float stepAngle)
{
  strokeWeight(2);
  stroke(255);
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

void drawCursor(PVector center)
{
  pushMatrix();
  translate(center.x, center.y, center.z);
  strokeWeight(3);
  stroke(240,0,0);
  line(-CURSOR_SIZE,0,0,CURSOR_SIZE,0,0);
  stroke(0,240,0);
  line(0,-CURSOR_SIZE,0,0,CURSOR_SIZE,0);
  stroke(0,0,240);
  line(0,0,-CURSOR_SIZE,0,0,CURSOR_SIZE);
  popMatrix();
}

void drawBoxRow(float angle)
{
  drawBox(0, angle, angle, 0);
  drawBox(100, angle, angle*2, 0);
  drawBox(200, angle*1.5, angle, 0);
  drawBox(-100, 0, angle, angle);
  drawBox(-200, angle, 0, angle*2.4);
}

void drawBox(float trX, float rotX, float rotY, float rotZ)
{
  fill(color(200, 128+int(trX), 0));
  pushMatrix();
  translate(trX, 0, 0);
  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);
  box(50);
  popMatrix();
}