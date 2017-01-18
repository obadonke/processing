interface IBox {
  void display();
  boolean isDead();
  void kill();
  boolean contains(float x, float y);
  Body getBody();
}