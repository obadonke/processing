// Nature of Code - page 58-59

class Boid implements IBoid {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float maxAcceleration;
  float size = 3;

  ITarget target;
  IBehaviour behaviour;
  
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

  Boid(float x, float y, float r, ITarget target, IBehaviour behaviour) {
    size = r;
    location = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.setMag(MAX_SPEED);
    maxSpeed = MAX_SPEED;
    maxAcceleration = MAX_ACCELERATION;
    acceleration = new PVector(0,0);
    this.target = target;
    this.behaviour = behaviour;
  }

  void applyBehaviours() {
    PVector seekForce = calcSeekForce(target.getLocation(this));
    applyForce(seekForce);
    PVector behaviourForce = behaviour.getForce(this);
    applyForce(behaviourForce);
  }
  
  void update() {
    acceleration.limit(maxAcceleration);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  PVector calcSeekForce(PVector target) {
    PVector desired = PVector.sub(target, location);

    float dist = desired.mag();
    if (dist < APPROACH_DISTANCE && ALLOW_ARRIVAL) {
      float speed = map(dist, 0, APPROACH_DISTANCE, 0, maxSpeed);
      desired.limit(speed);
    } else {
      desired.limit(maxSpeed);
    }

    return calcSteerForceFromDesired(desired);
  }

  PVector calcSteerForceFromDesired(PVector desired) {
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxSpeed);
    return steer;
  }

  void applyForce(PVector force) {
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
}
