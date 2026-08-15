import java.util.HashMap;


PVector CameraPosition = new PVector(0, 0, -1);
PVector CameraRotation = new PVector(0, 0, 0);
float yaw=0;
float pitch=0;
float lastMouseX;
float lastMouseY;
java.awt.Robot robot;
int centerX, centerY;
boolean recentering = false;
PImage grass;
float smoothDX = 0;
float smoothDY = 0;

int currentIndices = 0;

float smoothFactor = 1;
float sensitivity = 0.15;
ArrayList<Vertex> vertexBuffer = new ArrayList<Vertex>();
int[] indices = {
  0, 1, 2, // triangle 1
  2, 1, 3  // triangle 2
};
HashMap<Vertex, PVector> CalcuatedVertex= new HashMap<Vertex, PVector>();;

void setup()
{


  noCursor();
  size(1000, 1000);

  lastMouseX = mouseX;
  frameRate(60);
  centerX = width/2;
  centerY = height/2;

  try {
    robot = new java.awt.Robot();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  recenterMouse();

  grass = loadImage("grass.jpg");


  vertexBuffer.add(new Vertex(new PVector(0, 0, 0), new PVector(0, 0)));
  vertexBuffer.add(new Vertex(new PVector(1, 0, 0), new PVector(1, 0)));
  vertexBuffer.add(new Vertex(new PVector(0, 1, 0), new PVector(0, 1)));
  vertexBuffer.add(new Vertex(new PVector(1, 1, 0), new PVector(1, 1)));
  
  //for(int x = 0;x<100;x++)
  //{
  // vertexBuffer.add(new Vertex(new PVector(0+x, 0, 0), new PVector(0, 0)));
  //vertexBuffer.add(new Vertex(new PVector(1+x, 0, 0), new PVector(1, 0)));
  //vertexBuffer.add(new Vertex(new PVector(0+x, 1, 0), new PVector(0, 1)));
  //vertexBuffer.add(new Vertex(new PVector(1+x, 1, 0), new PVector(1, 1)));
  //}
}
float speed =0.1;

float area(PVector a, PVector b, PVector c) {
  return abs(
    (b.x - a.x) * (c.y - a.y) -
    (b.y - a.y) * (c.x - a.x)
  );
}
float edge(float ax, float ay, float bx, float by, float px, float py) {
  return (px - ax)*(by - ay) - (py - ay)*(bx - ax);
}


void DrawTriangle(Vertex V1, Vertex V2, Vertex V3) {

  // ---- unpack positions ----
  float ax = V1.Position.x;
  float ay = V1.Position.y;
  float bx = V2.Position.x;
  float by = V2.Position.y;
  float cx = V3.Position.x;
  float cy = V3.Position.y;

  // ---- unpack UVs ----
  float u1 = V1.UVcoords.x;
  float v1 = V1.UVcoords.y;
  float u2 = V2.UVcoords.x;
  float v2 = V2.UVcoords.y;
  float u3 = V3.UVcoords.x;
  float v3 = V3.UVcoords.y;

  // ---- bounding box ----
  int minX = (int)max(0, floor(min(ax, bx, cx)));
  int maxX = (int)min(width-1, ceil(max(ax, bx, cx)));
  int minY = (int)max(0, floor(min(ay, by, cy)));
  int maxY = (int)min(height-1, ceil(max(ay, by, cy)));

  // ---- triangle area ----
  float areaABC = edge(ax, ay, bx, by, cx, cy);
  if (areaABC == 0) return;

  float invArea = 1.0f / areaABC;

  int texW = grass.width;
  int texH = grass.height;
  int screenW = width;

  // ---- raster ----
  for (int y = minY; y <= maxY; y++) {
    for (int x = minX; x <= maxX; x++) {

      float wA = edge(bx, by, cx, cy, x, y) * invArea;
      float wB = edge(cx, cy, ax, ay, x, y) * invArea;
      float wC = edge(ax, ay, bx, by, x, y) * invArea;

      if (wA >= 0 && wB >= 0 && wC >= 0) {

        float U = wA*u1 + wB*u2 + wC*u3;
        float V = wA*v1 + wB*v2 + wC*v3;

        int tx = (int)(U * texW);
        int ty = (int)(V * texH);

        if (tx >= 0 && tx < texW && ty >= 0 && ty < texH) {
          pixels[y*screenW + x] = grass.pixels[ty*texW + tx];
        }
      }
    }
  }
}


void draw()
{
CalcuatedVertex.clear();
  background(255);
   background(0);

  loadPixels();
  grass.loadPixels();

  ArrayList<Vertex> vb = new ArrayList<Vertex>();
  for (Vertex v : vertexBuffer) vb.add(v.copy());
for(int i = 0; i<vertexBuffer.size();i+=4)
{
   ArrayList<Vertex> verts = CalculateNewVerticesForTriangle(vb.get(indices[0]+i),vb.get(indices[1]+i),vb.get(indices[2]+i));


if(verts != null)
{
  DrawTriangle(
    verts.get(0),
    verts.get(1),
    verts.get(2)
  );
}
 verts = CalculateNewVerticesForTriangle(vb.get(indices[3]+i),vb.get(indices[4]+i),vb.get(indices[5]+i)); //<>//
 
if(verts != null)
{
  DrawTriangle(
    verts.get(0),
    verts.get(1),
    verts.get(2)
  );
}
  updatePixels();
}






    if (recentering) {
      recentering = false;
      return; // ignore Robot event
    }


    float dx = mouseX - pmouseX;
    float dy = mouseY - pmouseY;

    smoothDX += (dx - smoothDX) * smoothFactor;
    smoothDY += (dy - smoothDY) * smoothFactor;

    yaw   -= smoothDX * sensitivity;
    pitch += smoothDY * sensitivity;

    pitch = constrain(pitch, -90, 90);
    yaw = (yaw + 360) % 360;

    recenterMouse();



  
  }






void recenterMouse() {
  // Get window position on the screen (works in Processing 3/4)
  java.awt.Point loc = ((java.awt.Component)surface.getNative()).getLocationOnScreen();

  int screenX = loc.x + centerX;
  int screenY = loc.y + centerY;
  recentering = true;
  robot.mouseMove(screenX, screenY);
}
ArrayList<Vertex> CalculateNewVertices(ArrayList<Vertex> vertexBuffer)
{

for (int i = 0; i < vertexBuffer.size(); i++) {
    PVector transformed = Rotate(vertexBuffer.get(i).Position);
    PVector projected = Perspective_Projection(transformed);

    if (projected != null) {
        vertexBuffer.get(i).Position = projected;
    }
    // else: skip or leave the original vertex untouched
}

  return vertexBuffer;
}

ArrayList<Vertex> CalculateNewVerticesForTriangle(Vertex point1, Vertex point2, Vertex point3)
{ 
  
  ArrayList<Vertex> verts = new ArrayList<Vertex>(); //<>//

  // ---- POINT 1 ----
  PVector projected1;
  if (CalcuatedVertex.containsKey(point1))
  {
    projected1 = CalcuatedVertex.get(point1);
  }
  else
  { 
    PVector rotated = Rotate(point1.Position);
    if (rotated.z <= 0) return null;

    projected1 = Perspective_Projection(rotated);
    CalcuatedVertex.put(point1, projected1);
  }
  // ---- POINT 2 ----
  PVector projected2;
  if (CalcuatedVertex.containsKey(point2))
  {
    projected2 = CalcuatedVertex.get(point2);
  }
  else
  {
    PVector rotated = Rotate(point2.Position);
    if (rotated.z <= 0) return null;

    projected2 = Perspective_Projection(rotated);
    CalcuatedVertex.put(point2, projected2);
  }

  // ---- POINT 3 ----
  PVector projected3;
  if (CalcuatedVertex.containsKey(point3))
  {
    projected3 = CalcuatedVertex.get(point3);
  }
  else
  {
    PVector rotated = Rotate(point3.Position);
    if (rotated.z <= 0) return null;

    projected3 = Perspective_Projection(rotated);
    CalcuatedVertex.put(point3, projected3);
  }
  println(CalcuatedVertex.size());
  // Create new vertices using cached projection
  verts.add(new Vertex(projected1, point1.UVcoords));
  verts.add(new Vertex(projected2, point2.UVcoords));
  verts.add(new Vertex(projected3, point3.UVcoords));
 
  return verts;
}


PVector Perspective_Projection(PVector pos) {


  float fov = radians(60);       // 60 degrees FOV
  float aspect = width / (float)height;

 //<>//
  float f = 1.0 / tan(fov / 2);  // focal length based on FOV
  float x_proj = (pos.x * f / aspect) / pos.z;
  float y_proj = (pos.y * f) / pos.z;

  // convert to screen coordinates
  float screenX = width / 2 + x_proj * width / 2;
  float screenY = height / 2 - y_proj * height / 2;

  return new PVector(screenX, screenY);
}

PVector Rotate(PVector Point)
{
  float YawAngle = radians(yaw);   // invert camera rotation
  float PitchAngle = radians(pitch);   // invert camera rotation

  float x_local = Point.x - CameraPosition.x;
  float y_local = Point.y - CameraPosition.y;
  float z_local = Point.z - CameraPosition.z;

  float x_rot = x_local * cos(YawAngle) - z_local * sin(YawAngle);
  float z_rot = x_local * sin(YawAngle) + z_local * cos(YawAngle);

  float y_rot =     y_local * cos(PitchAngle) - z_rot * sin(PitchAngle);
  float z_rot_new = y_local * sin(PitchAngle) + z_rot * cos(PitchAngle);

  return new PVector( x_rot,  y_rot,  z_rot_new);
}

void keyPressed() {
  float YawInRad = radians(yaw);
  float PitchInRad = radians(pitch);
  if (key == 'w' ) {

    CameraPosition.z += speed * cos(YawInRad);
    CameraPosition.x += speed * sin(YawInRad);
    CameraPosition.y += speed* sin(PitchInRad);  // move up
  } else if (key == 's') {

    CameraPosition.z -= speed * cos(YawInRad);
    CameraPosition.x -= speed * sin(YawInRad);
    CameraPosition.y -= speed* sin(PitchInRad);  // move up
  }

  if (key == 'a') {


    CameraPosition.x -= speed * cos(YawInRad);   // right is -cos
    CameraPosition.z += speed * sin(YawInRad);   // right is +sin
  } else if (key == 'd') {
    CameraPosition.x += speed * cos(YawInRad);   // left is +cos
    CameraPosition.z -= speed * sin(YawInRad);   // left is -sin
  }

  if (key == 't')
  {
    exit();
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    key = 'h';
  }
  if (key == 's' || key == 'S') {
    key = 'h';
  }
  if (key == 'a' || key == 'A') {
    key = 'h';
  }
  if (key == 'd' || key == 'D') {
    key = 'h';
  }
}
