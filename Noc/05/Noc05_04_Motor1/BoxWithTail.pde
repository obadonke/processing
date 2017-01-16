class BoxWithTail implements IBox {
  RevoluteJoint joint;
  Box head;
  Box tail;

  BoxWithTail(float x, float y) {
    float tailLen = 20;
    boolean reversed = (random(1) < 0.5);
    head = new Box(x, y, 16, 16, reversed ? color(200, 0, 200) : color(200, 0, 0));
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

  boolean isDead() {
    return head.isDead();
  }
}