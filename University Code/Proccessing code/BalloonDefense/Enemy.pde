public abstract class Enemy //<>//
{
  private int frameXPosition = 0;  //store all the values related to the image aminamtion values here
  private final int frameY = 0; // these are all the values related to the image and atlas
  private final int imageWidth = 17;
  private final int imageHeight = 40;
  private final int ConstantX;
  private final int BallonSizeX = 30;
  private final int BallonSizeY = 70;
  private PImage sprite; // this will store the image of the current frame of animation on the ballon
  private PVector Position;
  private int pathCounter = 0;// store the current index of path the enemy is following


  public Enemy(PVector EnemyPos, int pathCount, int AnimationStartX)
  {
    Position = EnemyPos; //constructor that sets the starting position of the enemy
    pathCounter = pathCount;
    setFrameXPosition(AnimationStartX);
    ConstantX = AnimationStartX;//we need a refrence thats constant to the intial value of the animation start
    sprite = atlas.get(AnimationStartX, 0, imageWidth, imageHeight); // give it an initial frame so it's not null
    sprite.resize(BallonSizeX, BallonSizeY);
  }

  public void setFrameXPosition(int FrameX)
  {

    frameXPosition =FrameX;
  }
  public Enemy(PVector EnemyPos, int pathCount)
  {
    this(EnemyPos, pathCount, 0);
  }


  public void Move(PVector target, float speed) // procedure related to the enemy that moves the enemy
  {

    PVector vector = PVector.sub(target, Position);// subtract to get a movement vector
    float distance = vector.mag(); // how far we are from the target

    if (distance < speed) { // if the speed is greater than the distance to the target we will overshoot the target therfore we just lock it into place
      Position.set(target);
    } else { // else we wont overshoot the target so move normally
      vector.normalize(); // here we normalise the vector to scale it down
      vector.mult(speed); // here i add some speed to the vector
      Position.add(vector); // and add the vector to the postion so it moves towards the target
    }
  }
  public boolean MouseCollision(PVector Position, float tolerance) // tolerance is the minimum distance the two postions need to be in order to return true
  {//this function is in the enemy class
    if (PVector.dist(this.Position, Position) <= tolerance)
    {
      return true;
    }

    return false;
  }

  public PImage UpdateAnimation() {//this class will update the animation for the a specfic object
    //this is in the enemy class
    sprite = atlas.get(frameXPosition, frameY, imageWidth, imageHeight); //here we can extract part of texture atlas image to get an image of 1 ballon
    sprite.resize(BallonSizeX, BallonSizeY);
    frameXPosition += imageWidth;//here we move along to the next image in the atlas by updating the x position to get that image and extract it

    //constant x will store the constant x position that will be passed throught this represents the starting point of the of all the frame images and if its multiplyed by two you just get the end point
    if (frameXPosition >= ConstantX + 85) frameXPosition = ConstantX; // here we will reset the counter so that the x will not go of screen therefore we will just loop throught the 5 images

    // each image is 17 pixels across so if we want to start at the 6th image in the atlas just do 17*5 = 85
    return sprite; // return the current image in the animation so that it can be drawn
  }
}
