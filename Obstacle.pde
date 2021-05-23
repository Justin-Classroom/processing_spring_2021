class Obstacle extends GameObject {
  
  Obstacle() {
    GO_SHAPE = 0;
  }
  
  void update(float speed) {
    x -= 5; 
  }
}
