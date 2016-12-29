// A static landing pad for the Lander

class LandingPad {
   PVector location;
   int w;
   int h;
   
   LandingPad(int x, int y, int w, int h) {
     location = new PVector(x,y);
     this.w = w;
     this.h = h;
   }
   
   void draw() {
     pushMatrix();
     translate(location.x, location.y);
     float hDelta = h/4.0;
     int edgeDist = w/2;
     stroke(0);
     fill(0,0,200);
     rect(-edgeDist, 0, w, h);
     int y = 0;
     
     stroke(200,200,0);
     for (int i = 1; i < 4; i++) {
       y += hDelta;
       line(-edgeDist, y, edgeDist, y);
     }
     popMatrix();
   }
}