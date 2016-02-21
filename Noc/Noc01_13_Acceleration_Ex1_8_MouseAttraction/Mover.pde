// Nature of Code - page 58-59
// Modified example of acceleration towards the mouse
// The Movers will lose interest in the mouse if the mouse is stationary for too many frames.
// The amount of time before a Mover loses interest is randomised using a Gaussian so that
// the majority of Movers will lose interest after about 300 frames.

// Movers outside of the maxDistanceRange don't follow the mouse as though they don't see it.
// However, if they've taken an interest in the mouse they become agitated when they lose track of it.
// They lose interest if they don't find the mouse again in the maxFrames... limit.

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topSpeed;
  PVector oldTarget;
  int interestFrames;
  int maxFramesBeforeLoseInterest;
  boolean everBeenInterested = false; // has mover ever taken an interest in the mouse?
  
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    topSpeed = 3;
    acceleration = new PVector(0, 0);
    oldTarget = new PVector(0, 0);
    maxFramesBeforeLoseInterest = 350+ (int)(generator.nextGaussian()*40);
    
    // start with no interest in initial mouse position
    interestFrames = maxFramesBeforeLoseInterest;
  }

  void update() {
    PVector newTarget = new PVector(mouseX, mouseY);
    boolean sameTarget = (newTarget.x == oldTarget.x  && newTarget.y == oldTarget.y);
    float agitation = 1;
    
    PVector dir = PVector.sub(newTarget, location);
    float distanceRange = dir.mag()/distanceStep;
    if (distanceRange < 1) distanceRange = 1;
    
    if (distanceRange < maxDistanceRange && (!sameTarget || (sameTarget && interestedInMouse()))) {
      if (sameTarget) {
        interestFrames++;
      } else {
        interestFrames = 0;
        everBeenInterested = true;
      }
      
      dir.normalize();
      
      if (mousePressed && mouseButton == LEFT) {
        // proportional to distance
        dir.mult(noise(location.x,location.y)*distanceRange/maxDistanceRange);
      }
      else
      {
        // inverse proportional to distance
        dir.mult(noise(location.x,location.y)/distanceRange);
      }
      acceleration = dir;
      oldTarget = newTarget;
    } else {
      if (interestedInMouse()) {
        // keep incrementing the count
        interestFrames++;
        agitation = 1.5;
      }
      acceleration = PVector.random2D();
      acceleration.mult(agitation*0.3*noise(location.x,location.y));
    }
    
    velocity.add(acceleration);
    velocity.limit(topSpeed*agitation);
    location.add(velocity);
  }
  
  boolean interestedInMouse() {
    return interestFrames < maxFramesBeforeLoseInterest;
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    
    if (interestedInMouse()) {
     fill(100,0,255);
    } else if (everBeenInterested) {
      fill(255,255,0);
    } else {
      fill(240);
    }
    ellipse(location.x, location.y, 24, 24);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}