class Platform extends GameObject {
  
  Platform() {
    GO_SHAPE = 0;
    w = 100;
    l = 20;
  }
  
  void update(float speed) {
    x -= 2; 
  }
  
  void draw() {
    super.draw();
    rect(x, y, w, l);
  }
}
