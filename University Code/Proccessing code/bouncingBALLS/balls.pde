class balls
{
  PVector position;
  PVector colour;
  float speed;

  balls(PVector pos,PVector clr ,float spd)
  {
   position = pos;
   colour = clr;
   speed = spd;
  }

  void updateBallPos()
  {
    position.x += speed;
    ellipse( position.x, position.y,10,10);
    if (position.x < 0 || position.x > width)
    {
      speed = -speed;
    }
  }
}
