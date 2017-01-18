// Spring - based on Nature of Code by Daniel Shiffman

class Spring {
  Body boundBody;      
  MouseJoint mouseJoint;
  int id;
  color c;

  Spring() {
    mouseJoint = null;
  }

  void bind(Body body, float x, float y) {
    if (isBound()) {
      unbind();
    }

    Vec2 t = box2d.coordPixelsToWorld(x, y);
    MouseJointDef mjd = new MouseJointDef();
    boundBody = body;
    mjd.bodyA = box2d.getGroundBody();
    mjd.bodyB = boundBody;
    mjd.target.set(t);

    mjd.maxForce = 1000.0 * body.m_mass;
    mjd.frequencyHz = 3.0;
    mjd.dampingRatio = 0.9;

    mouseJoint = (MouseJoint)box2d.world.createJoint(mjd);
    //mouseJoint.setTarget(t);
  }

  void unbind() {
    if (!isBound()) return;

    box2d.world.destroyJoint(mouseJoint);
    mouseJoint = null;
  }

  boolean isBound() {
    return mouseJoint != null;
  }

  void update(float x, float y) {
    if (!isBound()) return;

    mouseJoint.setTarget(box2d.coordPixelsToWorld(x, y));
  }

  void display() {
    if (!isBound()) return;

    Vec2 bodyPos = box2d.getBodyPixelCoord(boundBody);
    Vec2 jointPos = box2d.coordWorldToPixels(mouseJoint.getTarget());

    //pushMatrix();
    stroke(0);
    line(bodyPos.x, bodyPos.y, jointPos.x, jointPos.y);
    //popMatrix();
  }
}