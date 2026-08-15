float offset = 0;
boolean increase = false;
boolean alternate = true;
boolean shiftColum = false;
void setup()
{
  size(800, 400);



}
 void draw()
 {
 
  int sizeX = 50;
  int sizeY = 2;
  
  background(255);
  float speed = 0.05; // lower = slower movement
  offset += speed;

  for (int x= 0; x < width; x+= sizeX)
  {
    if (sizeX <= 5)
      increase =true;
    if (sizeX >= 50)
      increase = false;

    sizeX = increase ? sizeX + 5 : sizeX - 5;


  

    for (int y = 0; y < height; y += sizeY) {
      
           float wave = sin((radians(y)) + offset) * 50;
      float drawX = x + wave;
      
      if ((alternate && shiftColum) || (y == 0 && !alternate)) {
        fill(0);  
      } else {
        fill(255);  
      }

      rect(drawX, y, sizeX, sizeY);
      if(!shiftColum)
      {
        shiftColum = true;

        
      }
      else
       alternate = !alternate;
    }
    shiftColum = !shiftColum;
  }  
 }
 
