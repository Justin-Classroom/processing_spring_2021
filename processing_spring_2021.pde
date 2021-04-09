// 2d side-scrolling endless runner / platformer
// Object Oriented Programming Planning
// Objects - player, obstacles, platforms, points
// Features - jumping, crouching, -spawning game objects-,  points counter, restart game loop, end game conditions, -moving game objects-, collision

// points counter (class) extend gameobject
// override the update function
// use the speed parameter in order to increase amount of points gained
// store points
// have a public functions to access points
// function to increase points by a set amount (when passing obstacles)

ArrayList<GameObject> gameObjects;
Player player;

static final int PLAYER_POS_X = 100;
static final int SCORE_POS_X = 800;
static final int SCORE_POS_Y = 50;

static final int NUM_OF_OBSTACLES = 5;
static final int NUM_OF_PLATFORMS = 20;

int gameSpeed = 5;
int ground = 400;

PImage playerSprite;
PImage platformSprite;
PImage obstacleSprite1;
PImage obstacleSprite2;

void setup() {
  size(1000, 600);
  rectMode(CENTER);
  imageMode(CENTER);
  
  playerSprite = loadImage("p1_front.png");
  platformSprite = loadImage("grass.png");
  obstacleSprite1 = loadImage("boxItem.png");
  obstacleSprite2 = loadImage("brickWall.png");
  
  gameObjects = new ArrayList<GameObject>();
  
  // creating a player and score counter
  player = new Player();
  player.setSprite(playerSprite);
  player.setPos(PLAYER_POS_X, ground - (playerSprite.height / 2));
  gameObjects.add(player);
  
  GameObject score = new ScoreCounter();
  score.setPos(SCORE_POS_X, SCORE_POS_Y);
  gameObjects.add(score);
  
  // creating platforms and obstacles;
  for (int iter = 0; iter < NUM_OF_PLATFORMS; iter++) {
      GameObject platform = new Platform();
      platform.setSprite(platformSprite);
      platform.setPos(
        iter * platformSprite.width, 
        ground + (platformSprite.height / 2)
      );
      gameObjects.add(platform);
  }
  
  for (int iter = 0; iter < NUM_OF_OBSTACLES; iter++) {
      GameObject obstacle = new Obstacle();
      obstacle.setSprite(obstacleSprite1);
      gameObjects.add(obstacle);
  }
  
}

void draw() {
  background(#9A95E3);
  
  float timer = millis();
  if (timer % 10000 < 0.1) spawnObstacle();
  
  for (int i = 0 ; i < gameObjects.size(); i++) {
    GameObject object = gameObjects.get(i);
    object.draw();
    object.update(gameSpeed);
    
    // collision checking only for obstacles and platforms
    if (object instanceof Player || object instanceof ScoreCounter) continue;
    
    if (hasCrossedEnd(object)) object.setPos(i * platformSprite.width, ground + (platformSprite.height / 2));
    
    // discard objects that are on the opposite side of the game
    if (object.getX() > width / 2) continue;
    
    if (collision(player, object)) {
      object.setColor(color(255, 0, 0));
    } else {
      object.setColor(color(255, 255, 255));
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    player.jump();
  }
}

boolean hasCrossedEnd(GameObject object) {
  // 0 - left edge of the screen
  // object.getX() - center of the object
  // object.getWidth(); - full width of the object
  // if right side of the object crosses the left edge of the screen
  return false;
}

boolean collision(Player a, GameObject b) {
  // player to platform (rect to rect)
  if (b.GO_SHAPE == 0) {
    return rectToRectCollision(a, b);
  }
  
  // player to obstacle (rect to ellipse)
  if (b.GO_SHAPE == 1) {
    return rectToEllipseCollision(a, b);
  }
  
  return false;
}

boolean rectToRectCollision(GameObject a, GameObject b) {
   return (abs(a.getX() - b.getX()) - (a.getWidth() / 2) - (b.getWidth() / 2) <= 0 &&
    abs(a.getY() - b.getY()) - (a.getLength() / 2) - (b.getLength() / 2) <= 0);
}

boolean rectToEllipseCollision(GameObject a, GameObject b) {
  // testing closest edge
  float sideX = b.getX();
  float sideY = b.getY();
  
  // checking left and right edges
  if (b.getX() < a.getX() - (a.getWidth() / 2)) {
    sideX = a.getX() - (a.getWidth() / 2);
  } else if (b.getX() > a.getX() + (a.getWidth() / 2 )) {
    sideX = a.getX() + (a.getWidth() / 2 );
  }
  
  // checking top and bottom edge
  if (b.getY() < a.getY() - (a.getLength() / 2)) {
    sideY = a.getY() - (a.getLength() / 2);
  } else if (b.getY() > a.getY() + (a.getLength() / 2 )) {
    sideY = a.getY() + (a.getLength() / 2 );
  }
  
  // get distance from closest edges
  float distX = b.getX() - sideX;
  float distY = b.getY() - sideY;
  float distance = sqrt( (distX * distX) + (distY * distY) );
  
  if (distance <= b.getWidth() / 2) {
    return true;
  }
  
  return false;
}
