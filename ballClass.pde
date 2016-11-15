class Ball {

  //CLASS VARIABLES
  //initial positions
  float x= widthV/2;
  float y= heightV/2;

  float xspeed = 12;
  float yspeed = 12;

  float size = 60;
  // booleans for motion
  boolean restart = false;
  boolean end = false;
  boolean moveRight = false;
  boolean moveLeft = true;
  boolean moveUp = false;
  boolean moveDown = false;
  boolean rightwave = false;
  boolean leftwave = false;

  //controls the direction of motion through an array
  int [] dirArray = new int[3];
  {
    dirArray[0] = 1;
    dirArray[1] = -1;
  }
  // chooses the initial direction at random
  int dir = dirArray[int(random(1, 2))-1];

  // the player objects that the ball takes
  Paddle playerRight, playerLeft;

  //takes a wave array
  Wave [] w;

  //CONSTRUCTOR
  Ball(Paddle playerRight_, Paddle playerLeft_, Wave [] w_) {

    playerRight = playerRight_;
    playerLeft = playerLeft_;
    w = w_;
  }

  //FUNCTIONS
  void display() {
    pushStyle();
    noStroke();
    if (y<0) {
      dir*=-1;
    }
    if (y>height) {
      dir*=-1;
    }
    x = constrain(x, 0, widthV);
    if (x == 0) {
      // if ball is missed 
      //right player wins
      ++playerRight.score;

      // restart the sketch
      restart = true;

      // reposition ball at the middle of the screen
      x = widthV/2;
      y = heightV/2;

      //reposition the paddles at their initial positions
      playerRight.y = playerRight.yInitial;
      playerLeft.y = playerLeft.yInitial;
    } else if (x == widthV) {

      //Left player wins
      ++playerLeft.score;

      //restart the sketch
      restart = true;

      // reposition ball at the middle of the screen
      x = widthV/2;
      y = heightV/2;

      //reposition the paddles at their initial positions
      playerRight.y = playerRight.yInitial;
      playerLeft.y = playerLeft.yInitial;
    }  

    // gives fade out look of ball
    color p = color(255, 17, 184);
    for (int fade = 0; fade<30; ++fade) {
      fill(p, 100 - map(fade, 0, 30, 0, 150));
      ellipse(x, y, map(fade, 0, 30, 0, size), map(fade, 0, 30, 0, size));
    }
    popStyle();
  }
  void move() {
    // specifies when the ball is recieved and should reflect back
    x += xspeed;
    if (abs(x-playerRight.x) <= 10 && (playerRight.y- y<=26 && (playerRight.y- y) >=-228)) {
      if (abs(x-playerRight.x)==10) { x= playerRight.x-1;
      }
      moveRight = false;
      moveLeft = true;
      rightwave = true;
      xspeed *= -1;
    }
    if (abs(x-playerLeft.x) <= 10  && (playerLeft.y- y<=26 && playerLeft.y- y>=-228)) {
      if (abs(x-playerRight.x)==10) { x= playerLeft.x+1;
      }
      moveRight = true;
      moveLeft = false;
      leftwave = true;
      xspeed *= -1;
    }
    if (moveLeft) {
      y+=yspeed*dir;
    }
    if (moveRight) { 
      y+= yspeed*dir;
    }
  }
}