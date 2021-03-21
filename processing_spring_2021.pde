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

GameObject[] gameObjects;

static final int PLAYER_POS_X = 100;
static final int PLAYER_POS_Y = 300;
static final int SCORE_POS_X = 800;
static final int SCORE_POS_Y = 50;

static final int PLAYER_INDEX = 0;
static final int SCORE_INDEX = 1;

static final int NUM_OF_OBJECTS = 2;
static final int NUM_OF_OBSTACLES = 5;
static final int NUM_OF_PLATFORMS = 20;

int gameSpeed = 5;

PImage playerSprite;

void setup() {
  size(1000, 600);
  rectMode(CENTER);
  imageMode(CENTER);
  
  playerSprite = loadImage("p1_front.png");
  
  gameObjects = new GameObject[
    NUM_OF_OBJECTS +
    NUM_OF_OBSTACLES +
    NUM_OF_PLATFORMS
  ];
  
  // creating a player and score counter
  gameObjects[PLAYER_INDEX] = new Player();
  gameObjects[PLAYER_INDEX].setPos(PLAYER_POS_X, PLAYER_POS_Y);
  gameObjects[PLAYER_INDEX].setSprite(playerSprite);
  gameObjects[SCORE_INDEX] = new ScoreCounter();
  gameObjects[SCORE_INDEX].setPos(SCORE_POS_X, SCORE_POS_Y);
  
  // creating platforms and obstacles;
  for (int iter = NUM_OF_OBJECTS; iter < gameObjects.length; iter++) {
    if ( iter < NUM_OF_OBJECTS + NUM_OF_OBSTACLES) {
      gameObjects[iter] = new Obstacle();
    } else {
      gameObjects[iter] = new Platform();
    }
    
    float x = random(width + 100, width + 2000);
    float y = random(50, height - 50);
    
    gameObjects[iter].setPos(x, y);
  }
}

void draw() {
  background(#9A95E3);
  for (int i = 0 ; i < gameObjects.length; i++) {
    gameObjects[i].draw();
    gameObjects[i].update(gameSpeed);
    
    // collision checking only for obstacles and platforms
    if (i == PLAYER_INDEX || i == SCORE_INDEX) continue;
    
    if (hasCrossedEnd(gameObjects[i])) gameObjects[i].setPos(random(width + 100, width + 2000), random(50, height - 50));
    
    // discard objects that are on the opposite side of the game
    if (gameObjects[i].getX() > width / 2) continue;
    
    if (collision((Player)gameObjects[PLAYER_INDEX], gameObjects[i])) {
      gameObjects[i].setColor(color(255, 0, 0));
    } else {
      gameObjects[i].setColor(color(255, 255, 255));
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    ((Player)gameObjects[PLAYER_INDEX]).jump();
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
