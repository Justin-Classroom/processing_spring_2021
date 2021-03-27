class Player extends GameObject {
  
  private float velocity = 0;
  private float jumpForce = 20;
  private float gravity = -1;
  private float floor;
  
  Player() {
    GO_SHAPE = 0;
  }
  
  void setPos(float x, float y) {
    super.setPos(x, y);
    floor = y + l / 2;
  }
  
  void jump() {
    velocity = jumpForce;
  }
  
  void update(float speed) {
    
    y -= velocity;
    
    if (y + (l / 2) > floor) {
      y = floor - (l / 2);
      velocity = 0;
    } else {
      velocity += gravity;
    }
  }
}
