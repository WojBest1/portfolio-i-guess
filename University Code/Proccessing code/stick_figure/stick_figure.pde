PVector stickHead = new PVector(200,200);
int Headsize = 25;
int torsoSize =100;
int legSize = torsoSize+ 50;
int legSpread=50;
float progress = 0;
PVector center = new PVector(stickHead.x, stickHead.y + torsoSize/2);

ArrayList<PVector> OrignalPostions = new ArrayList<PVector>();
ArrayList<PVector> CurrentPostions = new ArrayList<PVector>();

void setup()
{
  size(400  ,400);

      // store all points relative to the center (hip)
  OrignalPostions.add(new PVector(stickHead.x - center.x, stickHead.y - center.y)); // head 0 
  OrignalPostions.add(new PVector(stickHead.x - center.x, stickHead.y + torsoSize - center.y)); // hip 1 
  OrignalPostions.add(new PVector(stickHead.x - center.x, stickHead.y + Headsize/2 - center.y)); // shoulder2 
  OrignalPostions.add(new PVector(stickHead.x - legSpread - center.x, stickHead.y + legSize - center.y)); // left leg3
  OrignalPostions.add(new PVector(stickHead.x + legSpread - center.x, stickHead.y + legSize - center.y)); // right leg4
  OrignalPostions.add(new PVector(stickHead.x - legSpread - center.x, stickHead.y + legSize/2 - center.y)); // left arm5
  OrignalPostions.add(new PVector(stickHead.x + legSpread - center.x, stickHead.y + legSize/2 - center.y)); // right arm6

for (int i = 0; i < OrignalPostions.size(); i++) {
  CurrentPostions.add(new PVector(0, 0));
}
  frameRate(30);
  
  
}
float rotationAngle = 0;

void draw()
{
  
  background(255);
        rotationAngle += radians(3); 
  for (int i =0 ; i< OrignalPostions.size();i++ )
  {


    // rotate the original vector
    
  float x_local = OrignalPostions.get(i).x;
  float y_local = OrignalPostions.get(i).y;

  float x_rot = x_local * cos(rotationAngle) - y_local * sin(rotationAngle);
  float y_rot = x_local * sin(rotationAngle) + y_local * cos(rotationAngle);

PVector p = CurrentPostions.get(i);
p.x = center.x + x_rot;
p.y = center.y + y_rot;
  
  }
      ellipse(CurrentPostions.get(0).x, CurrentPostions.get(0).y,                       Headsize, Headsize);
      
      
      line(CurrentPostions.get(1).x, CurrentPostions.get(1).y,  CurrentPostions.get(2).x,CurrentPostions.get(2).y);
      
      
      line(CurrentPostions.get(2).x,CurrentPostions.get(2).y,            CurrentPostions.get(5).x,CurrentPostions.get(5).y);
      line(CurrentPostions.get(2).x,CurrentPostions.get(2).y,           CurrentPostions.get(6).x,CurrentPostions.get(6).y);
      
      
      line(CurrentPostions.get(1).x, CurrentPostions.get(1).y,         CurrentPostions.get(3).x, CurrentPostions.get(3).y);
      line(CurrentPostions.get(1).x, CurrentPostions.get(1).y,         CurrentPostions.get(4).x, CurrentPostions.get(4).y);   
          
}
