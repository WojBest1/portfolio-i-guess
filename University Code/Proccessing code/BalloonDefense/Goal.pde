public class Goal
{
  private PVector Position;

  public Goal(PVector Position)//constructor
  {
    this.Position= Position;
  }


  public boolean EnemyCollision(PVector Position, float tolerance) // tolerance is the minimum distance the two postions need to be in order to return true
  {//this function is in the goal class
    if (PVector.dist(this.Position, Position) <= tolerance)
    {
      return true;
    }

    return false;
  }
}
