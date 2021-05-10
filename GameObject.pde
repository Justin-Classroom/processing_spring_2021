class GameObject {
  public float GO_SHAPE; // 0 for rect, 1 for ellipse
  
  boolean isActive;
  
  float x;
  float y;
  float w;
  float l;
  color c = color(255, 255, 255);
  
  Sprite sprite;
  
  GameObject() {
    sprite = new Sprite();
    isActive = true;
  }
  
  float getX() { return x; }
  float getY() { return y; }
  
  float getWidth() { return w; }
  float getLength() { return l; }
  
  // homework: add setSize(float w, float l)
  
  void setPos(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void setColor(color c) {
    this.c = c;
  }
  
  void setSprite(PImage img) {
    this.sprite.setSprite(img);
    this.w = img.width;
    this.l = img.height;
  }
  
  void update(float speed) {
  }
  
  void draw() {
    this.sprite.draw(this.x, this.y);
  }
}
