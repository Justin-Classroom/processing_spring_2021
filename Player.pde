class Player extends GameObject {
  
  private float velocity = 0;
  private float jumpForce = 20;
  private float gravity = -1;
  private float floor;
  private boolean isJumping;
  
  Player() {
    GO_SHAPE = 0;
    isJumping = false;
  }
  
  void setPos(float x, float y) {
    super.setPos(x, y);
    floor = y + l / 2;
  }
  
  void jump() {
    if (!isJumping) {
      velocity = jumpForce;
      isJumping = true;
    }
  }
  
  void update(float speed) {
    
    y -= velocity;
    
    if (y + (l / 2) > floor) {
      y = floor - (l / 2);
      velocity = 0;
      isJumping = false;
    } else {
      velocity += gravity;
    }
  }
}
