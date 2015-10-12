class Hexagon 
{
  float radius;
  float w;
  float h;
  boolean isVert;
  
  Hegaxon(float radius,boolean isVert)
  {
    
  }
  
  void Draw() 
  {
  }
  
  float Height() 
  { 
     if (isVert) 
       return radius;
     else
       return h;
  }
  float Width() 
  { 
     if (isVert) 
       return h;
     else
       return radius;
  }
}

