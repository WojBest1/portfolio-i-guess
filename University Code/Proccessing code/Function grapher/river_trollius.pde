size(800, 800);
rectMode(CENTER);
PVector lastPoint = new PVector(width/2, height/2);
boolean first = true;
line(width/2,0,width/2,height);
line(0,height/2,width,height/2);
for (int x = -width/2; x < width/2; x++) {
  
  float y = cos(2*pow(x,2))*50;  // scale down so it fits in window

  PVector currentPoint = new PVector(width/2 + x, height/2 - y);

  if (first) {
    first = false;
  } else {
    line(lastPoint.x, lastPoint.y, currentPoint.x, currentPoint.y);
  }

  lastPoint = currentPoint; // update lastPoint for next line
}
