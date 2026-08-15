import java.awt.Robot; // a robot is a class that lets me control the perphirals and change their values  its found in a package //<>//
//that controls all the gui and and graphics related functions
import java.awt.AWTException;//i am importing a type of error that we can catch when a class like robot throws an error without it
//java wouldnt recognise the error
Goal goal;
Robot robot; // we are creating a robot type where all the robot values will be stored
ArrayList<PVector> PathPosition = new ArrayList<PVector>();//stores all the postions for the path that the enemy will follow
ArrayList<Enemy> CurrentEnemies = new ArrayList<Enemy>();//stores all enemy classes
ArrayList<Explosion> CurrentExplosion = new ArrayList<Explosion>();//stores all enemy classes
PImage atlas;//refrence to the image atlas
PImage Background;//this is where the background will be stored
PImage ExplosionImage;//stores all the explotion images
PImage SplashScreen;//stores all the explotion images
PImage GameOverScreen;//stores all the explotion images
boolean GameOver = false;
int health = 25;
int lastSpawnTimestamp; // stores the last time the timer was entered to time it correctly
int lastAnimationTimestamp;
int currentScore = 0; // the current score that the player has achived whilst playing the game
int HighScore;
final int mousePressCollisionTolerance = 40;// the tolerance for the mouse to press the ballon and the collison to be deteceted
final int ScreenSizex = 800; // this is the x and the y size of the screen  the y needs to be scaled accordingly to x so the image isnt streched
final int ScreenSizey = int(ScreenSizex * 0.75);
final int specialEnemyAnimStartX = 85;  // starting X position on the atlas for Bomb_Enemy
final int normalEnemyAnimStartX = 0;  // starting X position on the atlas for Enemy
final int step = 5; // the step that the cursor will move by
final int enemySpeed = 3; // the speed at which the enemy will move
final int goalCollisionTolerance = 5; // the distance the enemy needs to be to the goal to reach it
final int intrvalsTimeBetweenEnemySpawns =500; // the time in ms until the next enemy spawns in
final int intrvalsTimeBetweenAnimationUpdates =200; // the time in ms until the ballon animations update again
final int splashDisplayTime =3000; // the time in ms the splash screen is shown
final int hudXOffset = 200; // how far from the right side the text will be placed
final int healthY = 50; // this is where the health text will be drawn on the y axis
final int highScoreY = 100; // this is where the high score text will be drawn on the y axis
final int currentScoreY = 150; // this is where the current score text will be drawn on the y axis
final int startingPathIndex = 1; // index of the path point an enemy will follow when spawned
final float enemyDistanceTolerance = 0.5; // the minimum distance the enemy needs to be to a path point to move onto the next path point
final File file = new File(sketchPath("highScore.txt")); //assign this file to the file variable i will use txt to store the high score

void settings()//cant define the size with variables in setup so settings is needed
{
  size(ScreenSizex, ScreenSizey);//define the screen size

  try {
    robot = new Robot();  // this can throw AWTException
  }
  catch (AWTException e) { // here we will catch this exception to prevent crashing
  }
}
void setup() {

  atlas = loadImage("Balloon Sprites Texture Atlas.png");//refrence to the image atlas
  Background = loadImage("background.png");//this is where the background will be stored
  ExplosionImage = loadImage("Explosion Images.png");
  SplashScreen = loadImage("splashScreen.jpg");
  GameOverScreen = loadImage("gameOver.jpg");

  PathPosition();

  if (!file.exists())// if the file dosent exist we will need to create it
  {
    String[] lines = {"0"};// give the intial value to 0
    saveStrings("highScore.txt", lines);// store the value 0 in the file we create here
    println("File created!");
  } else
  {
    String[] lines = loadStrings("highScore.txt");//if the file already exists no point of creating it so we just read from it
    HighScore = int(lines[0]); // assign the value to the high score variable which will be displayed
     println("File successfully loaded!");
  }

  goal = new Goal(PathPosition.get(PathPosition.size()-1));// intilize the value here and make the the goal the final path position


  Background.resize(width, height); // the background will take up the whole screen
  SplashScreen.resize(width, height);
  GameOverScreen.resize(width, height);
}


void draw() {

  background(255); //reset the background

  if (GameOver)//when the players health is 0 GameOver will be true
  {

    image(GameOverScreen, 0, 0); //the death screen will be showed
    return;
  }


  if (ShowSplashScreen()) //at the start the splash screen will be shown for 3 seconds
  {

    image(SplashScreen, 0, 0);
    return; // returns so the rest of the game code is not executed and the game doesnt start
  }


  image(Background, 0, 0);//the image will be center at the corner 0,0
  ShowSplashScreen();
  fill(0);           // text colour (black)
  textSize(20);      // font size
  //display text to show information

  text("health:" + health, width - hudXOffset, healthY);
  text("High Score:" + HighScore, width - hudXOffset, highScoreY);
  text("Current Score:" + currentScore, width - hudXOffset, currentScoreY);

  MoveTheEnemies(); //call diffrent functions that do diffrent things to break it down top down design
  CreateNewEnemies();
  updateTheAnimations();
  updateExplosions();

  //fill(0);
  //ellipse(goal.Position.x, goal.Position.y, 10, 10);//temporary visual example of goal
  //fill(255);
}

boolean timer(int lastTime, int Interval) // created a timer function to prevent code repetion
  //last time will be the ellipse the last time the function was entered
{
  if (millis() - lastTime >= Interval)// when spawn interval has passed we will eneter this for
  {
    return true; // return true as the time interval has passed
  }
  return false;
}

void mousePressed() {

  PVector mousePos = new PVector(mouseX, mouseY); // create a vector for the mouse position

  for (int i = CurrentEnemies.size() - 1; i >= 0; i--) { // loop backwards throught the enemys to make sure all the enemys have been checked

    Enemy current = CurrentEnemies.get(i);
    if (current.MouseCollision(mousePos, mousePressCollisionTolerance)) { // check if there is a collison by passing throught the values to the function

      Explosion explosion = new Explosion(ExplosionImage, current.Position); // create a new animation to be progressed
      CurrentExplosion.add(explosion); //add the animation to the list


      currentScore++; // when a ballon is clicked on our score will increase
      if (currentScore>HighScore)
      {
        HighScore = currentScore; // make the high score the current score as that is what it will be
      }
      if (current instanceof health_Enemy) // checks if the enemy is a special enemy
        health-=5; // if so take health away from clicking on it
      CheckHealth();
      CurrentEnemies.remove(i); // if there is a collison destroy the enemy by removing it from the list
      println("Enemy hit!");
    }
  }
}
void updateExplosions()
{
  //loop backwards throught the explosions so we can remove them safely
  for (int i = CurrentExplosion.size() - 1; i >= 0; i--)
  {
    Explosion exp = CurrentExplosion.get(i); //get the current explosion
    if (!exp.animate()) //if the explosion is done
    {
      CurrentExplosion.remove(i); //remove it from the list
    }
  }
}

void updateTheAnimations()
{
  // Check timer once per frame instead of per enemy
  boolean advanceFrame = timer(lastAnimationTimestamp, intrvalsTimeBetweenAnimationUpdates);
  if (advanceFrame) lastAnimationTimestamp = millis();  // reset timer to prevent multiple triggers

  imageMode(CENTER); // set image mode to center to draw at the center of the balloon
  for (int i = 0; i < CurrentEnemies.size(); i++)//loop throught all the enemys
  {
    Enemy e = CurrentEnemies.get(i); // set to improve readability

    if (advanceFrame)
    {
      // When the time interval has passed update animation to the next frame
      e.UpdateAnimation();
    }

    // Draw the current sprite at the enemys position
    image(e.sprite, e.Position.x, e.Position.y);
  }
  imageMode(CORNER); // reset image mode so the background is drawn in corner mode
}


void MoveTheEnemies()
{

  for (int i = CurrentEnemies.size() - 1; i >= 0; i--)//loops throught all the enemys to individually move each one
  {
    Enemy current = CurrentEnemies.get(i);//create a temporary variable here prevent code repetion and improve readability

    if (PVector.dist(current.Position, PathPosition.get(current.pathCounter)) > enemyDistanceTolerance)// if the distance from the current path position the
      // enemy is following is not near with
      //a tolerace of 0.1 to the enemy position then we move the enemy towards that path position
      current.Move(PathPosition.get(current.pathCounter).copy(), enemySpeed);
    else if (current.pathCounter < PathPosition.size()-1) //else the enemy is near the current path position so we will move onto the next path position
      current.pathCounter++;
    else if (goal.EnemyCollision(current.Position, goalCollisionTolerance)) // here once the the path counter is higher than path counter size it means we have reached the end so just check here for collison
    {//with the goal
      println("Enemy has reached the goal!");
      if (CurrentEnemies.get(i) instanceof health_Enemy)
        health++;
      else
        health--;
      CheckHealth();
      CurrentEnemies.remove(i);//remove the enemy object
    }
  }
}
void CreateNewEnemies()
{
  if (timer(lastSpawnTimestamp, intrvalsTimeBetweenEnemySpawns))//check if enought time has passed to create a new enemy
  {
    lastSpawnTimestamp = millis();  // update the spawn timer
    if ((int)random(7) == 1)// use a random generator that the special enemy has a 20 percent chace of spawning
    {
      CurrentEnemies.add(new health_Enemy(PathPosition.get(0).copy(), startingPathIndex, specialEnemyAnimStartX));//create a new special enemy at the start after a second has passed
      println("A new ballon health enemy has been created!");
    } else
    {
      CurrentEnemies.add(new Balloon_Enemy(PathPosition.get(0).copy(), startingPathIndex));//create a new enemy at the start after a second has passed
      println("A new ballon enemy has been created!");
    }
  }
}


void PathPosition()
{
  //all the poitions of the path the enemy will follow
  PathPosition.add(new PVector(round(width*0.01125), round(height*0.46666667)));
  PathPosition.add(new PVector(round(width*0.1425), round(height*0.46666667)));
  PathPosition.add(new PVector(round(width*0.1425), round(height*0.20833333)));
  PathPosition.add(new PVector(round(width*0.3175), round(height*0.20833333)));
  PathPosition.add(new PVector(round(width*0.3175), round(height*0.725)));
  PathPosition.add(new PVector(round(width*0.08), round(height*0.725)));
  PathPosition.add(new PVector(round(width*0.08), round(height*0.89166665)));
  PathPosition.add(new PVector(round(width*0.66125), round(height*0.89166665)));
  PathPosition.add(new PVector(round(width*0.66125), round(height*0.625)));
  PathPosition.add(new PVector(round(width*0.47375), round(height*0.625)));
  PathPosition.add(new PVector(round(width*0.47375), round(height*0.38333333)));
  PathPosition.add(new PVector(round(width*0.66125), round(height*0.38333333)));
  PathPosition.add(new PVector(round(width*0.66125), round(height*0.108333334)));
  PathPosition.add(new PVector(round(width*0.41125), round(height*0.108333334)));
  PathPosition.add(new PVector(round(width*0.41125), round(height*0.016666668)));
  //it calcuates the scale by multiplying the width or height by the scaling factor so that
  //the point will always be on the same postion on the image no mater the the width or height
  //path points are for the enemy movement
}

void CheckHealth()
{
  if (health <= 0) // check if the player has no health
  {
    String[] lines = new String[1];
    lines[0] = str(HighScore); //access the first line
    saveStrings("highScore.txt", lines); // store the score as the high score in the file
    GameOver = true;
  }
}
boolean ShowSplashScreen()
{

  if (timer(0, splashDisplayTime) == true) //call the timer at the start
  {
    return false; // false will be returned till the timer is over
  }
  return true;//when the timer is over true will be returned and the game will start
}
//void keyPressed() {

//  if (robot != null) {
//    java.awt.Point p = java.awt.MouseInfo.getPointerInfo().getLocation(); // here we will get the pointer position on the screen so that we can edit it
//    //and move it to a place that we need it to be with robot
//    int x = (int)p.getX(); // here we assign those values mouseX mouseY cant be used as they only say the postion on the canvas
//    int y = (int)p.getY();//whilst robot needs screen postions

//    if (keyCode == UP) robot.mouseMove(x, y - step);
//    if (keyCode == DOWN) robot.mouseMove(x, y + step);
//    if (keyCode == LEFT) robot.mouseMove(x - step, y);
//    if (keyCode == RIGHT) robot.mouseMove(x + step, y);

//    if (key == ' ') {  // space character
//      println("PathPostion.add(new PVector(width*" + ((float)mouseX/width) + ", height*" + ((float)mouseY/height) + "));");
//      //this will output it in a format that i can copy and paste directly into the code
//      //it calcuates the scale by multiplying the width or height by the scaling factor so that
//      //the point will always be on the same postion on the image no mater the the width or height
//    }
//  }
//}
