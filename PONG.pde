//Nadine and Araz

//GLOBAL VARIABLES
Wave []w = new Wave[100000];
color g = color(0, 240, 51);
float finalscore = 10;

// counters for the array
int counter = 0; 
int counterStart = 0;
int startcount;
int startcountStart = 0;

//determines whether the game should restart or not
boolean startpage = true;

//Specifies the height and width of the sketch
int heightV = 1200;
int widthV = 1200;

//boolean to differentiate between right and left players
boolean right = true;
boolean left = false;
boolean rightWinner = false;
boolean leftWinner = false;

//initiates the left and right player objects
Paddle pRight = new Paddle(right);
Paddle pLeft = new Paddle(left);

// initiates the ball object
Ball ball = new Ball(pRight, pLeft, w);
int [] speed = new int[2];

void setup() {
  size(1200, 1200);
  speed[0] = -1;
  speed[1] = 1;
}

void draw() {

  //DRAW BASIC BACKGROUND
  frameRate(60);
  background(0);
  textAlign(CENTER);
  if (startpage) {
    //begin drawing the waves every en seconds
    if (millis()%10 == 0) {
      w[counterStart] = new Wave(random(200), random(width), random(height));  
      ++counterStart;
    }
    if (counterStart>=5) {
      startcountStart = counterStart-5;
    } else {
      startcountStart = 0;
    }
    //displays and makes the waves grow and disappear
    for (int i = startcountStart; i<counterStart; ++i) {
      w[i].size+=10;
      --w[i].disappear;
      w[i].display();
    }

    startpage();


    if (keyPressed & keyCode == UP) {
      delay(10);
      startpage = false;
    }
  } else {
    if (ball.rightwave) {
      w[counter] = new Wave(random(200), ball.x, ball.y);
      ++counter;
      ball.rightwave = false;
      ball.leftwave = false;
    }
    if (ball.leftwave) {
      w[counter] = new Wave(random(200), pLeft.x, pLeft.y);
      ++counter;
      ball.rightwave = false;
      ball.leftwave = false;
    }
    //only draws 5 waves maximum at a time
    if (counter>=5) {
      startcount = counter-5;
    } else {
      startcount = 0;
    }
    // displays and makes the waves grow and disappear
    for (int i = startcount; i<counter; ++i) {
      w[i].size+=20;
      if (w[i].disappear >0 ) {
        --w[i].disappear;
        w[i].display();
      }
    }

    // midLine
    pushStyle();
    for (int i = 0; i<height; i+=5)
    {
      fill(g);
      noStroke();
      ellipse(width/2, i, 2, 2);
    }
    popStyle();

    // draw the players and the ball
    if (ball.restart == false) {
      pRight.display();
      pRight.move();
      pLeft.display();
      pLeft.move();
      ball.display();
      ball.move();
    }

    // restart game if ball is not caught
    if (ball.restart) {
      if (pRight.score != finalscore && pLeft.score != finalscore) {
        pRight.display();
        pLeft.display();
        ball.display();
      }
      ball.x = widthV/2;
      ball.y = heightV/2;
      pRight.move();
      pLeft.move();
      //pRight.display();
      //pLeft.display();
      //ball.display();
      ball.yspeed *= speed[constrain(int(random(0, 2)), 0, 1)];
      ball.xspeed *= speed[constrain(int(random(0, 2)), 0, 1)];
    }
    // draw the score at the top
    textSize(30);
    pushMatrix();
    translate(width/2 -(width/12), 30);
    rotate(PI/2);
    fill(g);
    text(pLeft.score, 0, 0);
    popMatrix();
    pushMatrix();
    translate(width/2 + (width/12)- pRight.pWidth/2, 30);
    rotate(-PI/2);
    fill(g);
    text(pRight.score, 0, 0);
    popMatrix();

    if (keyPressed) {
      if (ball.restart == true) {
        // reset the score

        if (keyCode == UP &&( pRight.score ==finalscore || pLeft.score == finalscore)) {
          rightWinner = false;
          leftWinner = false;
          pRight.score = 0;
          pLeft.score = 0;
          ball.end = false;
        }
      }

      ball.restart = false;
    }
    if (pRight.score == finalscore) {
      println("still");
      //LEFT PLAYER MESSAGE
      ball.end = true;
      ball.restart = true;
      pushMatrix();
      translate(0.25* width, height/2);
      rotate(PI/2);
      textSize(45);
      text("YOU LOSE :(", 0, 0);
      text("Press UP to restart", 0, 60);
      popMatrix();
      pushMatrix();
      translate(0.75*width, height/2);
      rotate(-PI/2);
      textSize(45);
      text("YOU WIN :)", 0, 0);
      text("Press UP to restart", 0, 60);
      popMatrix();
      rightWinner = false;
      leftWinner = false;
      if (millis()%15 == 0) {
        w[counter] = new Wave(random(200), random(width), random(height));  
        counter+=1;
      }
    }
    if (pLeft.score == finalscore) {
      ball.end = true;
      ball.restart = true;
      pushMatrix();
      translate(0.25* width, height/2);
      rotate(PI/2);
      textSize(45);
      text("YOU WIN! :)", 0, 0);
      text("Press UP to restart", 0, 60);
      popMatrix();
      pushMatrix();
      translate(0.75*width, height/2);
      rotate(-PI/2);
      textSize(45);
      text("YOU LOSE :(", 0, 0);
      text("Press UP to restart", 0, 60);
      popMatrix();
      rightWinner = false;
      println("still");
      leftWinner = false;
    }
  }
}



void keyPressed() {
  //PLAYERS' MOVEMENT
  switch(keyCode) {
  case DOWN:
    pRight.moveDOWN= true;
    break;
  case UP:
    pRight.moveUP= true;
    break;
  }
  switch(key) {
  case 'a':
    pLeft.moveUP = true;
    break;
  case 'w':
    pLeft.moveUP = true;
    break;
  case 'd':
    pLeft.moveDOWN = true;
    break;
  case 's':
    pLeft.moveDOWN = true;
    break;  
  case ' ':
    saveFrame();
    break;
  }
}


void keyReleased() {
  //STOPPING THE MOVEMENT
  switch(keyCode) {
  case DOWN:
    pRight.moveDOWN= false;
    break;
  case UP:
    pRight.moveUP= false;
    break;
  }
  switch(key) {
  case 'a':
    pLeft.moveUP = false;
    break;
  case 'w':
    pLeft.moveUP = false;
    break;
  case 'd':
    pLeft.moveDOWN = false;
    break;
  case 's':
    pLeft.moveDOWN = false;
    break;
  }
}

void startpage() {

  pushStyle();
  textAlign(CENTER);
  textSize(120);
  fill(0, 255, 0);
  text("PONG", width/2, height/2);
  textSize(40);
  text("First player to 10 points wins!", width/2, height/2 + 150);
  textSize(40);
  text("Press UP to start", width/2, height/2 + 210);
  popStyle();
}


void mousePressed() {
  println(pRight.y - mouseY);
}