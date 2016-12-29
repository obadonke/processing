class Line {
  PVector origin;
  PVector direction;
  
  Line(PVector origin, PVector direction) {
    this.origin = origin;
    this.direction = direction.copy();
    this.direction.normalize();
  }
  
  PVector pointAt(float distance) {
    PVector result = direction.copy();
    result.mult(distance);
    result.add(origin);
    return result;
  }
}

class Circle {
  PVector center;
  float radius;
  
  Circle(PVector center, float radius) {
    this.center = center;
    this.radius = radius;
  }
  
  boolean contains(PVector point) {
    return PVector.sub(center,point).mag() < radius;
  }
}

class Rect {
  int x;  // left
  int y;  // top
  int width;
  int height;
  
  Rect(float x, float y, float width, float height) {
    this.x = (int)x;
    this.y = (int)y;
    this.width = (int)width;
    this.height = (int)height;
  }
  
  PVector getTopLeft() {
    return new PVector(x, y);
  }
  
  PVector getBottomRight() {
    return new PVector(x+width, y+height);
  }
}

static class Geometry {
  final static float ZERO_TOL = 0.0001;
  
  static PVector[] getPointsWhereLineIntersectsCircle(Line line, Circle circle) {
    // based on https://en.wikipedia.org/wiki/Line%E2%80%93sphere_intersection
    // lineDirection assumed to be normalised.
    // if line does not intersect, circleCentre is returned as the intersection point.
    
    PVector[] result = new PVector[2];
    
    PVector vO_C = PVector.sub(line.origin, circle.center);
    float ldotO_C = line.direction.dot(vO_C);
    float magO_C = vO_C.mag();
    float sq = (ldotO_C*ldotO_C) - (magO_C*magO_C) + (circle.radius*circle.radius);
    if (sq < -ZERO_TOL) {
      // no solution
      result[0] = result[1] = circle.center;
      return result;
    }
    
    float sqroot = sqrt(sq);
    result[0] = line.pointAt(-ldotO_C-sqroot);
    
    if (sq < ZERO_TOL) {
      // one solution
      result[1] = result[0];
    } else {
      result[1] = line.pointAt(-ldotO_C+sqroot);
    }
    
    return result;
  }
}