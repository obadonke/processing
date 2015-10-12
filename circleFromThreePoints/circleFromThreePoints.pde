import point2line.*;
Vect2 lastPoint = null;
int MAX_CIRCLES = 20;

PointBuffer inputBuffer;
PointBuffer circlePoints;

void setup()
{
  size(800, 800);
  inputBuffer = new PointBuffer(3,false);
  circlePoints = new PointBuffer(MAX_CIRCLES*2,true);
  
  strokeWeight(5);
}

void draw()
{
  background(180);
  drawCircles();
  
  if (!inputBuffer.isFull())
  {
    drawPointInput();
  }
  else
  {
    addCircleFromInput();
  }
}

void drawPointInput()
{
  Vect2[] points = inputBuffer.getPoints();
  
  int numPoints = inputBuffer.numPoints();
  
  for (int i = 0; i < numPoints-1; i++)
  {
    line(points[i].x,points[i].y,points[i+1].x,points[i+1].y);
  }
  
  if (numPoints > 0)
  {
    line(points[numPoints-1].x,points[numPoints-1].y,mouseX,mouseY);
  }
  else
  {
    point(mouseX, mouseY);
  }
}

void drawCircles()
{
  int circleBufferSize = circlePoints.numPoints();
  Vect2[] points = circlePoints.getPoints();
  
  for (int i = 0; i < circleBufferSize; i+= 2)
  {
     float diameter = points[i+1].x; 
     int gray = int(min(map(diameter,0,width,80,255),255));
     fill(gray);   
     ellipse(points[i].x,points[i].y,diameter, diameter);
  }
}

Vect2 calculatePerpVector(Vect2 a, Vect2 b, int magnitude)
{
  Vect2 result = b.subtracted(a);
  result.rotate(HALF_PI);
  result.setMagnitude(magnitude);
  
  return result;
}

void mousePressed()
{
  if (mouseButton == RIGHT) {
    inputBuffer.clear();
    return;
  }

  Vect2 mousePos = new Vect2(mouseX, mouseY);
  inputBuffer.add(mousePos);
}

void addCircleFromInput()
{
  Vect2[] points = inputBuffer.getPoints();
  addCircleFromThreePoints(points[0], points[1], points[2]);
}

void addCircleFromThreePoints(Vect2 ptA, Vect2 ptB, Vect2 ptC)
{
  Vect2 ptAB = Vect2.midpoint(ptA,ptB);
  Vect2 ptBC = Vect2.midpoint(ptB,ptC);
  Vect2 perpAB = calculatePerpVector(ptA, ptB,100);
  Vect2 perpBC = calculatePerpVector(ptB, ptC,100);
  Vect2 ptAB2 = ptAB.added(perpAB);
  Vect2 ptBC2 = ptBC.added(perpBC);
  
  Vect2 intersect = Space2.lineIntersection(ptAB,ptAB2,ptBC, ptBC2);
  
  if (intersect != null)
  {
    float ellipseDiameter = Vect2.distance(ptA, intersect)*2; 
    circlePoints.add(intersect);
    circlePoints.add(new Vect2(ellipseDiameter, ellipseDiameter));   
  }

  inputBuffer.clear();
}


