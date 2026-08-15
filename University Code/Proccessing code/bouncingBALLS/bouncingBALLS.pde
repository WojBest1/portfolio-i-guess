ArrayList<balls> ballList = new ArrayList<balls>();

void setup()
{
  size(500,500);
    for (int i = 0 ; i < height ; i+= 1)
  {
  
    ballList.add(new balls(new PVector(10,i) , new PVector(0,0,0), random(4, 9)));
  }
}
void draw()
{
  background(255);
  for (int i = 0 ; i < ballList.size() ; i++)
  {
    ballList.get(i).updateBallPos();
    
  }
  
}
