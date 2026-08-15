
PVector TriangleCenter = new PVector(0 ,0,180);
PVector CameraPosition = new PVector(0 ,0,0);
ArrayList<PVector> OrignalPostions = new ArrayList<PVector>();
ArrayList<PVector> CurrentPostions = new ArrayList<PVector>();

int triangleHeight = 50;
int triangleWidthX = 50;
int triangleWidthZ =triangleWidthX;
int[] vertices;
void setup()
{
  
        size(400,400);
       
     OP();
        
        
    

    vertices =  new int[]{
          0, 1, 
          0,2,
          0,3,
          0,4,
          1,2,
          1,3,
          4,2,
          4,3
          
        };
        
// option A: copy originals (recommended)
for (int i = 0; i < OrignalPostions.size(); i++) {
  CurrentPostions.add(OrignalPostions.get(i).copy());
}

    
  frameRate(60);
  
      
}
float rotationAngle = 0;

void draw()
{
      background(255);
        rotationAngle += radians(3); 
        
                  
          //// inside draw(), per-vertex rotate
          for (int i = 0; i < OrignalPostions.size(); i++) {
            // make a local vector relative to the rotation centre
            float x_local = OrignalPostions.get(i).x - TriangleCenter.x;
            float z_local = OrignalPostions.get(i).z - TriangleCenter.z;
          
            float x_rot = x_local * cos(rotationAngle) - z_local * sin(rotationAngle);
            float z_rot = x_local * sin(rotationAngle) + z_local * cos(rotationAngle);
          
            PVector p = CurrentPostions.get(i);
            p.x = TriangleCenter.x + x_rot;
            p.z = TriangleCenter.z + z_rot;
          }
          
            
   
       
       for (int i = 0; i < vertices.length; i += 2) {

        PVector pos = Perspective_Projection(CurrentPostions.get(vertices[i]));
       PVector pos1 = Perspective_Projection(CurrentPostions.get(vertices[i + 1]));
       TriangleCenter.add(new PVector(-CameraPosition.x,-CameraPosition.y,-CameraPosition.z));
              OP();
          line(pos.x,pos.y,pos1.x,pos1.y);      

          }

    
  

}
PVector Perspective_Projection(PVector pos) {
     
    float fov = radians(90);       // 60 degrees FOV
    float aspect = width / (float)height;
    float near = 0.1;       // near plane

    if (pos.z < near) pos.z = near;

    float f = 1.0 / tan(fov / 2);  // focal length based on FOV
    float x_proj = (pos.x * f / aspect) / pos.z;
    float y_proj = (pos.y * f) / pos.z;

    // convert to screen coordinates
    float screenX = width / 2 + x_proj * width / 2;
    float screenY = height / 2 - y_proj * height / 2;

    return new PVector(screenX, screenY);
}
void OP()
{
    OrignalPostions.clear();
     OrignalPostions.add(new PVector(TriangleCenter.x,TriangleCenter.y+triangleHeight,TriangleCenter.z)); // tip 
    
        OrignalPostions.add(new PVector(TriangleCenter.x+triangleWidthX,TriangleCenter.y-triangleHeight,TriangleCenter.z-triangleWidthZ)); // forward right
    
        OrignalPostions.add(new PVector(TriangleCenter.x-triangleWidthX,TriangleCenter.y-triangleHeight,TriangleCenter.z-triangleWidthZ)); // forward left
        
        OrignalPostions.add(new PVector(TriangleCenter.x+triangleWidthX,TriangleCenter.y-triangleHeight,TriangleCenter.z+triangleWidthZ)); // backwards right
    
        OrignalPostions.add(new PVector(TriangleCenter.x-triangleWidthX,TriangleCenter.y-triangleHeight,TriangleCenter.z+triangleWidthZ)); // backswards left
         
  
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    CameraPosition.z = 1;
  }
  if (key == 's' || key == 'S') {
    CameraPosition.z = -1;
  }
  if (key == 'a' || key == 'A') {
    CameraPosition.x = 1;
  }
  if (key == 'd' || key == 'D') {
    CameraPosition.x = -1;
  }
  if (key == 'q' || key == 'Q') {
    CameraPosition.y = 1;  // move up
  }
  if (key == 'e' || key == 'E') {
    CameraPosition.y = -1; // move down
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    CameraPosition.z = 0;
  }
  if (key == 's' || key == 'S') {
    CameraPosition.z = 0;
  }
  if (key == 'a' || key == 'A') {
    CameraPosition.x = 0;
  }
  if (key == 'd' || key == 'D') {
    CameraPosition.x = 0;
  }
  if (key == 'q' || key == 'Q') {
    CameraPosition.y = 0;
  }
  if (key == 'e' || key == 'E') {
    CameraPosition.y = 0;
  }
}
