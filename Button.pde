class Button extends Rect {
  
  String text;
  
  void draw() {
    textSize(18);
    text(text, x, y);
    noFill();
    stroke(0, 0, 0);
    rect(x, y, w, h);
  }
}
