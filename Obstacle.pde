class Obstacle extends GameObject {
  
  Obstacle() {
    GO_SHAPE = 1;
  }
  
  void update(float speed) {
    x -= 5; 
  }
}
