public class Balloon_Enemy extends Enemy // stores all the data related to the ballon enemy
{
  public Balloon_Enemy(PVector EnemyPos, int pathCount, int AnimationStartX) // constructor
  {
    super(EnemyPos, pathCount, AnimationStartX);// pass everything to the super as all the methods are found there
  }
  public Balloon_Enemy(PVector EnemyPos, int pathCount) // constructor
  {
    super(EnemyPos, pathCount);// pass everything to the super as all the methods are found there
  }
}
