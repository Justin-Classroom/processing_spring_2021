class Platform extends GameObject {
  
  Platform() {
    GO_SHAPE = 0;
  }
  
  void update(float speed) {
    x -= 2; 
  }
}
