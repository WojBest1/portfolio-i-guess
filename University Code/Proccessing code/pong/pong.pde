PVector size = new PVector(1800,900); //<>//
PVector BallPos = new PVector(1800/2,900/2);
byte ballSize = 20;
int VectorSize =20;
PVector vector = new PVector(VectorSize,VectorSize);
PVector paddlePostion  = new PVector(0,0);
PVector AIpaddlePostion  = new PVector(0,0);
int PlayerScore = 0;
int AIScore = 0;
int playerPaddleSize = 300;
int AIPaddleSize = 300;
float minThreshold = 0.5;
float maxThreshold = 1.5;
    float jitterX = 0;
    float jitterY  = 0;

void setup()
{
 size(1800,900) ;
 frameRate(60);
}
void RecalculateVector()
{
    // Left wall
    if(BallPos.x <= 0)
    {
        if(paddlePostion.y > BallPos.y) AIScore++; 
        else if(paddlePostion.y + 300 < BallPos.y) AIScore++;

        // flip X direction
        if(vector.x < 0) vector.x = VectorSize;
        // flip Y if needed
        if(vector.y < 0) vector.y = -VectorSize;
        else vector.y = VectorSize;
    }

    // Top wall
    else if(BallPos.y <= 0)
    {
        if(vector.y < 0) vector.y = VectorSize;
        if(vector.x < 0) vector.x = -VectorSize;
        else vector.x = VectorSize;
    }

    // Right wall
    else if(BallPos.x >= size.x)
    {
        if(AIpaddlePostion.y > BallPos.y) PlayerScore++; 
        else if(AIpaddlePostion.y + AIPaddleSize < BallPos.y) PlayerScore++;

        if(vector.x > 0) vector.x = -VectorSize;
        if(vector.y < 0) vector.y = -VectorSize;
        else vector.y = VectorSize;
    }

    // Bottom wall
    else if(BallPos.y >= size.y)
    {
        if(vector.y > 0) vector.y = -VectorSize;
        if(vector.x < 0) vector.x = -VectorSize;
        else vector.x = VectorSize;
    }

    // Apply random jitter AFTER bouncing
    jitterX = random(minThreshold, maxThreshold);
    jitterY = random(minThreshold, maxThreshold);

    if(vector.x > 0) vector.x += jitterX;
    else vector.x -= jitterX;

    if(vector.y > 0) vector.y += jitterY;
    else vector.y -= jitterY;
}

void draw()
{
 background(255);
  
         text(str(PlayerScore), 500, 500);     
        textSize(32);            
        fill(0);               
    text(str(AIScore), 1000, 500);     
        textSize(32);            
        fill(0);            

  // Move paddle while key is held down
  if (keyPressed) {
    if (key == 'w' && paddlePostion.y > 0) {
      paddlePostion.y -= 10;
    }
    if (key == 's' && paddlePostion.y + playerPaddleSize < size.y) {
      paddlePostion.y += 10;
    }
  }

  
  
  rect(paddlePostion.x, paddlePostion.y , 20, playerPaddleSize); 
  
  
 if(AIpaddlePostion.y >BallPos.y && AIpaddlePostion.y>0)
  {
    AIpaddlePostion.y-= 10;
  }
   if(AIpaddlePostion.y +AIPaddleSize < BallPos.y && AIpaddlePostion.y +AIPaddleSize < size.y)
  {
    AIpaddlePostion.y+=10;
  }
  
  
  

  rect(size.x-20, AIpaddlePostion.y , 20, AIPaddleSize); 
  
  
  
  ellipse(BallPos.x,BallPos.y,ballSize,ballSize );
  
  BallPos = PVector.add(BallPos,vector);
  
 
  if(BallPos.x <= 0 ||BallPos.x >= size.x  || BallPos.y <= 0||BallPos.y >= size.y)
  {
    RecalculateVector();
    
  }


}
