
  
  void setup()
  
  {
    size(1000, 1000);  
  }


PVector BallPos = new PVector(500, 500);
PVector BallVelocity = new PVector(3,2);
float numOfPoints = 4;    
    
void draw()
{
 
background(255);
BallPos.add(BallVelocity);
circle(BallPos.x,BallPos.y,10);
float angle = radians(360 / numOfPoints);
float currentAngle = radians(-45);

PVector CirclePoint = new PVector(width/2, height/2);
float radius = 300;

PVector firstPoint = null;
PVector previousPoint = null;

for (int i = 0; i < numOfPoints; i++)
{
  float x = CirclePoint.x + radius * cos(currentAngle);
  float y = CirclePoint.y + radius * sin(currentAngle);

  PVector currentPoint = new PVector(x, y);

  // Draw vertex
  //square(currentPoint.x, currentPoint.y, 10);

  // Connect to previous vertex
  if (previousPoint != null)
  {
    line(previousPoint.x, previousPoint.y,
         currentPoint.x, currentPoint.y);
         
            PVector lineVector = new PVector(previousPoint.x-currentPoint.x,previousPoint.y-currentPoint.y);
    PVector PointVector = new PVector(BallPos.x-currentPoint.x,BallPos.y-currentPoint.y);
    float dotProduct =  lineVector.dot(PointVector);
    
    float t = dotProduct / lineVector.dot(lineVector);
    
    PVector ClosestPoint = PVector.add(
        new PVector(currentPoint.x, currentPoint.y),
        new PVector(lineVector.x * t, lineVector.y * t)
    );
   if (PVector.dist(ClosestPoint, BallPos) < 5)
{
    PVector normal = new PVector(-lineVector.y, lineVector.x);
    normal.normalize();

    // Only bounce if moving towards the line
    if (BallVelocity.dot(normal) > 0)
        normal.mult(-1);

    float d = BallVelocity.dot(normal);

    BallVelocity.sub(PVector.mult(normal, 2 * d));

    numOfPoints++;
}
  
  }

  if (firstPoint == null)
  {
    firstPoint = currentPoint.copy();
  }
  
 
  

  previousPoint = currentPoint;
  currentAngle += angle;
  
  
  
}

// Connect last point back to first point
line(previousPoint.x, previousPoint.y,
     firstPoint.x, firstPoint.y);
     
}

void keyPressed() {
  if (key == 'a') {
    numOfPoints++;
  }
}
