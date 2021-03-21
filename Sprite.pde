class Sprite {
  
  PImage sprite;
  
  // Sprite sprite = new Sprite().setSprite(image);
  Sprite() {}
  
  Sprite setSprite(PImage img) {
    this.sprite = img;
    return this;
  }
  
  void draw(float x, float y) {
    try {
      image(this.sprite, x, y);
    } catch (Exception e) {
      println(e);
    }
  }
}
