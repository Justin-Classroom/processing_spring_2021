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



// object oriented programming (OOP)
// 4 main concepts
// encapsulation - functions, class
// abstraction - class, variables
// inheritance - extends (parent-child class)
// polymorhpism - become many things


ArrayList<GameObject> gameObjects;
ArrayList<Obstacle> obstacles;
Player player;

static final int PLAYER_POS_X = 100;
static final int SCORE_POS_X = 800;
static final int SCORE_POS_Y = 50;

static final int NUM_OF_OBSTACLES = 5;
static final int NUM_OF_PLATFORMS = 20;

int gameSpeed = 5;
int ground = 400;
float timer = 0;

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
  obstacles = new ArrayList<Obstacle>();
  
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
      obstacle.isActive = false;
      gameObjects.add(obstacle);
      obstacles.add((Obstacle) obstacle);
  }
  
}

void draw() {
  background(#9A95E3);
  
  gameMenu();
  
}

void gameMenu() {
  textAlign(CENTER, CENTER);
  textSize(40);
  text("Infinite Runner", width / 2, 1*height / 3);
  textSize(18);
  text("Start Game", width/ 2, height / 2);
  noFill();
  stroke(0, 0, 0);
  rect(width / 2, height / 2, 180, 60);
}

void gameplay() {
  timer += 1;
  float duration = 180;
  if (timer == duration) {
    spawnObstacle();
    timer = 0;
  }
  
  for (int i = 0 ; i < gameObjects.size(); i++) {
    GameObject object = gameObjects.get(i);
    if (!object.isActive) continue;
    
    object.draw();
    object.update(gameSpeed);
    
    // collision checking only for obstacles and platforms
    if (object instanceof Player || 
      object instanceof ScoreCounter || 
      object.getX() > width / 2) 
        continue;
    
    if (hasCrossedEnd(object)) {
      if (object instanceof Platform) object.setPos(i * platformSprite.width, ground + (platformSprite.height / 2));
      if (object instanceof Obstacle) object.isActive = false;
      continue;
    }
    
    if (collision(player, object)) {
      object.setColor(color(255, 0, 0));
    } else {
      object.setColor(color(255, 255, 255));
    }
  }
}

void mousePressed() {
  if (pointToRectCollision(mouseX, mouseY, width / 2, height / 2, 180, 60)) {
    println("Clicked Start!");
  }
}

void keyPressed() {
  if (key == ' ') {
    player.jump();
  }
}

// grab an obstacle
// check if isActive is false
// move it to the right of the screen
// set the isActive to true
void spawnObstacle() {
  for (int i = 0; i < obstacles.size(); i++) {
    Obstacle obstacle = obstacles.get(i);
    if (obstacle.isActive) continue;
    
    // move to the start location
    obstacle.setPos(width, ground - obstacle.getLength() / 2);
    
    obstacle.isActive = true;
    
    break;
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





boolean pointToRectCollision(float pointX, float pointY, float rectX, float rectY, float rectWidth, float rectHeight) {
  return (pointX > rectX - (rectWidth / 2) && pointX < rectX + (rectWidth / 2)) &&
    (pointY > rectY - (rectHeight / 2) && pointY < rectY + (rectHeight / 2));
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
