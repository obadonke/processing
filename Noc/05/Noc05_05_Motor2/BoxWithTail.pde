class BoxWithTail implements IBox {
  RevoluteJoint joint;
  Box head;
  Box tail;

  BoxWithTail(float x, float y) {
    float boxSize = 30;
    float tailLen = 30;
    boolean reversed = (random(1) < 0.5);
    head = new Box(x, y, boxSize, boxSize, reversed ? color(200, 0, 200) : color(200, 0, 0));
    tail = new Box(x+tailLen/2, y, tailLen, 4, color(200, 40, 40));

    RevoluteJointDef rjd = new RevoluteJointDef();
    rjd.initialize(head.body, tail.body, head.body.getWorldCenter());
    rjd.motorSpeed = reversed ? TWO_PI : -TWO_PI;
    rjd.maxMotorTorque = 1000;
    rjd.enableMotor = true;

    joint = (RevoluteJoint)box2d.world.createJoint(rjd);
  }

  void toggleMotor() {
    boolean motorEnabled = joint.isMotorEnabled();
    joint.enableMotor(!motorEnabled);
  }

  void display() {
    head.display();
    tail.display();
  }

  void kill() {
    head.kill();
    tail.kill();
  }
  
  Body getBody() {
    return head.getBody();
  }
  
  boolean isDead() {
    if (head.isDead())
    {
      tail.kill();
    }
    
    return head.isDead();
  }
  
  boolean contains(float x, float y) {
    if (isDead()) return false;
    
    return head.contains(x, y);
  }
}