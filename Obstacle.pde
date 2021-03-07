class Obstacle extends GameObject {
  
  Obstacle() {
    GO_SHAPE = 1;
    w = 50;
    l = 50;
  }
  
  void update(float speed) {
    x -= 5; 
  }
  
  void draw() {
    super.draw();
    ellipse(x, y, w, l);
  }
}
