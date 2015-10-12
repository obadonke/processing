// Collect points for some operation or another.
class PointBuffer
{
  int totalPoints;
  int nextIndex;
  Vect2[] points;
  boolean allowCycle;

  PointBuffer(int maxPoints, boolean cycle)
  {
    points = new Vect2[maxPoints];
    totalPoints = 0;
    nextIndex = 0;
    allowCycle = cycle;
  }

  void add(Vect2 point)
  {
    if (totalPoints == points.length && !allowCycle)
        return;
    
    if (totalPoints < points.length)
      ++totalPoints;
      
    points[nextIndex] = point;
    
    nextIndex = (nextIndex + 1) % points.length;
  }

  Vect2[] getPoints()
  {
    return points;
  }

  int numPoints()
  {
    return totalPoints;
  }

  boolean isFull()
  {
    return totalPoints == points.length;
  }

  void clear()
  {
    nextIndex = 0;
    totalPoints = 0;
  }
}

