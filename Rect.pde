class Rect {
  
  protected float x;
  float y;
  float w;
  float h;
  
  void setPos(float x, float y) {
    if (x - (w / 2) < 0) {
      this.x = w / 2;
    } else if (x + (w / 2) > width) {
      this.x = width - w;
    } else {
      this.x = x;
    }
    this.y = y;
  }
  
}
