class ScoreCounter extends GameObject {
  
  float score = 0;
  
  // update the score based on time
  void update(float speed) {
    super.update(speed);
    score += speed;
  }
  
  void draw() {
    text(score, 800, 50);
  }
  
  void changeScore(float amount) {
    score += amount;
  }
  
  public float getScore() { return this.score; }
  
  public void reset() { this.score = 0; }
}
