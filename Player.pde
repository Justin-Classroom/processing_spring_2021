class Player extends GameObject {
  
  private float velocity = 0;
  private float jumpForce = 20;
  private float gravity = -1;
  private float floor;
  
  Player() {
    GO_SHAPE = 0;
    w = 66;
    l = 92;
    floor = PLAYER_POS_Y + l / 2;
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
  
  void draw() {
    sprite.draw(x, y);
  }
  
}
