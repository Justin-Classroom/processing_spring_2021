class Player extends GameObject {
  
  Player() {
    GO_SHAPE = 0;
    w = l = 50;
  }
  
  void update(float speed) {
    
  }
  
  void draw() {
    rect(x, y, w, l);
  }
  
}
