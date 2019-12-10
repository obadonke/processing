// Nature of Code - page 58-59

static class BoidParams {
  static final float MAX_FORCE = 3;
  static final float MAX_SPEED = 5;
  static final float MAX_ACCELERATION = 0.4;
  static final float ALMOST_ZERO = 0.0001;
  static final float NEIGHBOUR_DIST = 100;
}

class Boid implements IBoid {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float maxAcceleration;
  float size = 3;
  
  ArrayList<WeightedBehaviour> behaviours;
  
  private final ITarget myTargetIdentity = new ITarget() {
    void display() {
    }

    PVector getLocation(IBoid vehicle) { 
      return Boid.this.location;
    }
  };

  ITarget asTarget() {
    return myTargetIdentity;
  }

  Boid(float x, float y, float r, ArrayList<WeightedBehaviour> behaviours) {
    size = r;
    location = new PVector(x, y);
    velocity = PVector.random2D();
    maxSpeed = BoidParams.MAX_SPEED;
    velocity.setMag(BoidParams.MAX_SPEED);
    maxAcceleration = BoidParams.MAX_ACCELERATION;
    acceleration = new PVector(0,0);
    this.behaviours = behaviours;
  }

  void applyBehaviours() {
    PVector resultantForce = new PVector(0,0);
    float totalWeight = 0;
    for (WeightedBehaviour wb: behaviours) {
      PVector force = wb.behaviour.getForce(this);
      if (force == null) continue;

      force.sub(velocity);
      float weight = wb.getWeight();
      force.mult(weight);
      totalWeight += weight;
      resultantForce.add(force);
    }
    
    if (totalWeight > 0.001) {
      resultantForce.div(totalWeight);
      applyForce(resultantForce);
    }
  }
  
  void update() {
    acceleration.limit(maxAcceleration);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    force.limit(BoidParams.MAX_FORCE);
    acceleration.add(force);
  }

  void display() {
    float theta = velocity.heading() + PI/2;


    pushMatrix();
    translate(location.x, location.y);

    stroke(0);
    strokeWeight(2);
    fill(240);
    rotate(theta);
    beginShape();
    vertex(0, -size*2);
    vertex(-size, size*2);
    vertex(size, size*2);
    endShape(CLOSE);
    popMatrix();
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
  
  PVector getVelocity() {
    return velocity.copy();
  }

  PVector getLocation() {
    return location.copy();
  }
  
  float getMaxForce() {
    return BoidParams.MAX_FORCE;
  }
  
  void debugDisplay() {
    for (WeightedBehaviour wb: behaviours) {
      wb.behaviour.display();
    }
  }
}