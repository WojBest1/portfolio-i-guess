public class Explosion
{
  private  float initalTime = 0; // the time the explosion was created
  private  PImage[] sprites = new PImage[4]; // array to hold the frames of the explosion animation
  private  final int imageWidth = 64;
  private  final int imageHeight = 60;
  private  int currentFrame = 0; // store the current frame of animation
  private  PVector position; // the postion where the explosion will be drawn

  public Explosion(PImage explosionImage, PVector pos)
  {
    sprites[0] = explosionImage.get(0, 0, imageWidth, imageHeight); // get first frame from atlas
    sprites[1] = explosionImage.get(imageWidth, 0, imageWidth, imageHeight); // get second frame ect ect
    sprites[2] = explosionImage.get(imageWidth *2, 0, imageWidth, imageHeight);
    sprites[3] = explosionImage.get(imageWidth *3, 0, imageWidth, imageHeight);
    position = pos; // set where the explosion should appear

    this.initalTime = millis(); // store the current time as start time for animation
  }

  public boolean animate() { // play the explosion animation

    int frameDuration = 100; // how long each frame should be shown
    int elapsed = millis() - int(initalTime); // time passed since explosion started
    currentFrame = elapsed / frameDuration; // calculate current frame

    if (currentFrame < sprites.length) { // if there are still frames left
      imageMode(CENTER); // draw at the center
      image(sprites[currentFrame], position.x, position.y); // draw current frame
      imageMode(CORNER); // reset mode so other stuff draws normally
      return true; // animation still going
    } else
      return false; // animation finished
  }
}
