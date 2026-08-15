import java.util.HashSet;
int GenerationCount = 0;
boolean Generation =false;
boolean progressGenerationOnce =false;
HashSet<String> SquarePosition = new HashSet<String>();
//cloes up show rules then show then show plane for patterns and for behaviours show rockets 
String Loadfile = "Rocket.txt";
//rules = 40 make glider
//Planes = 10
//Rocket = 2
//at the end show star = 100
int gridSize =2;
int brushSize = 100; // brush width/height in number of grid squares
int loadingXoffset = 0;//600 rocket offeset
int loadingYoffset = 0;
void setup()
{
  frameRate(60);
  size(1000, 700);
  background(11, 25, 44);

  stroke(67);

  // vertical linesS
  for (int x = 0; x <= width; x += gridSize) {
    line(x, 0, x, height);
  }

  // horizontal lines
  for (int y = 0; y <= height; y += gridSize) {
    line(0, y, width, y);
  }
}
void draw()
{

int boxW = 200;
int boxH = 100;
int margin = 10;

int x = width - boxW - margin;
int y = 5;



  if (mousePressed)
  {
    int xCenter = (mouseX / gridSize) * gridSize;
    int yCenter = (mouseY / gridSize) * gridSize;

    int halfBrush = brushSize / 2;

    for (int i = -halfBrush; i <= halfBrush; i++)
    {
      for (int j = -halfBrush; j <= halfBrush; j++)
      {
        int xPos = xCenter + i * gridSize;
        int yPos = yCenter + j * gridSize;

       
     
      if(!SquarePosition.contains(xPos + "," + yPos))
      {
        SquarePosition.add(xPos + "," + yPos);
           createAliveSquare(xPos,yPos);  
      }

      }
    }
  }
  if (Generation||progressGenerationOnce)
  {
   // println("enter generation"+SquarePosition.size());
    KillCells();
    progressGenerationOnce = false;
    GenerationCount++;
  }
  //DrawCells();
  
  // clear area
fill(0);
noStroke();
rect(x, y, boxW, boxH);

// text
fill(255);
textSize(16);
text("Generation per second: " + int(frameRate), x + 10, y + 20);
text("Draw Mode: " + !Generation, x + 10, y + 40);
text("Generation: " + GenerationCount, x + 10, y + 60);
text("Population: " + SquarePosition.size(), x + 10, y + 80);

}


void KillCells()
{
  //int cellskilled = 0;
  String[] cells = SquarePosition.toArray(new String[0]);
  ArrayList<String> CellsToDelete = new ArrayList<>();

  for (int i = 0; i < cells.length; i++) {
    // Get the string at index i
    String cell = cells[i];       // e.g., "10,20"

    // Split at the comma
    String[] parts = cell.split(",");  // ["10", "20"]

    // Convert to integers
    int x = Integer.parseInt(parts[0]);
    int y = Integer.parseInt(parts[1]);

    int neighbourCount = NeighbourCheck(x, y);

    if (neighbourCount <2 || neighbourCount >3)
    {
   createDeadSquare(x,y);
      CellsToDelete.add(x+","+y);
     // cellskilled++;
    }
  }
    // println("cells ready to kill"+SquarePosition.size());
  reviveCells();
 // println("cells killed" +cellskilled); //<>// //<>//
  for (String cell : CellsToDelete) {
    SquarePosition.remove(cell); //<>//
  }
       //println("cells killed"+SquarePosition.size());
}
void reviveCells() {
    ArrayList<String> CellsToAdd = new ArrayList<>();
    HashSet<String> deadNeighboursChecked = new HashSet<>();

    for (String Alive : SquarePosition) {
        String[] parts = Alive.split(",");
        int x = Integer.parseInt(parts[0]);
        int y = Integer.parseInt(parts[1]);

        if (!deadNeighboursChecked.contains(x + "," + y)) {

            int[][] offsets = {
                {gridSize, 0}, {-gridSize, 0}, {0, gridSize}, {0, -gridSize},
                {gridSize, gridSize}, {-gridSize, -gridSize}, {-gridSize, gridSize}, {gridSize, -gridSize}
            };

            for (int[] off : offsets) {
                int nx = x + off[0];
                int ny = y + off[1];
                String key = nx + "," + ny;

                // Only check dead neighbours that havent been checked yet
                if (!SquarePosition.contains(key) && !deadNeighboursChecked.contains(key)) {
                    if (NeighbourCheck(nx, ny) == 3) {
                        CellsToAdd.add(key);

                                            
                          createAliveSquare(nx,ny); 
                    }
                    deadNeighboursChecked.add(key); // mark as checked
                }
            }
        }
    }

    for (String cell : CellsToAdd) {
        SquarePosition.add(cell);
    }
      //println("cells revived "+SquarePosition.size());
}

int NeighbourCheck(int x, int y)
{
  int neighbourCount = 0;
  if (SquarePosition.contains((x+gridSize)+","+y))
  {
    neighbourCount++;
  }
  if (SquarePosition.contains((x-gridSize)+","+y))
  {
    neighbourCount++;
  }
  if (SquarePosition.contains(x+","+(y+gridSize)))
  {
    neighbourCount++;
  }
  if (SquarePosition.contains(x+","+(y-gridSize)))
  {
    neighbourCount++;
  }

  if (SquarePosition.contains((x+gridSize)+","+(y+gridSize)))
  {
    neighbourCount++;
  }
  if (SquarePosition.contains((x-gridSize)+","+(y-gridSize)))
  {
    neighbourCount++;
  }
  if (SquarePosition.contains((x-gridSize)+","+(y+gridSize)))
  {
    neighbourCount++;
  }
  if (SquarePosition.contains((x+gridSize)+","+(y-gridSize)))
  {
    neighbourCount++;
  }
  return neighbourCount;
}
void keyPressed() { //<>// //<>//
   if (key == 'c') {
 SquarePosition.clear(); //<>//
  for (int y = 0; y <= height; y += gridSize) {
      for (int x = 0; x <= width; x += gridSize) {
   createDeadSquare(x,y);
        
  }
  }
    
}
  if (key == ' ') { // ASCII for space
    Generation = !Generation;
    //println("pressed space"+SquarePosition.size());
  }
if (key == 's') {
  String[] oldCells = SquarePosition.toArray(new String[0]);

  String[] cells = new String[oldCells.length + 1];
  cells[0] = gridSize+",0";   // first line = size

  for (int i = 0; i < oldCells.length; i++) {
    cells[i + 1] = oldCells[i];
  }

  saveStrings("save.txt", cells);
  println("Saved " + oldCells.length + " cells!");
}

if (key == 'l') {
  boolean first = true;
  String[] loadedCells = loadStrings(Loadfile);
  int orignalSize = 1;
  for (String cell : loadedCells) {
    
        String[] parts = cell.split(",");
        int x = Integer.parseInt(parts[0]);
        int y = Integer.parseInt(parts[1]);
        int Scaledx = x / orignalSize * gridSize +loadingXoffset;
         int Scaledy = y / orignalSize * gridSize +loadingYoffset;
         
    if(!first){
    SquarePosition.add(Scaledx+","+Scaledy);
       createAliveSquare(Scaledx,Scaledy); 
    }
    else
    {
      orignalSize = x;
      first = false;
    }

  }
  println("Loaded " + loadedCells.length + " cells!");
}

  if (keyCode == RIGHT) {
  progressGenerationOnce = true; //<>// //<>//
}
 //<>//
 
}
void createAliveSquare(int x,int y)
{
        stroke(67);
      fill(255, 255, 0);
      rect(x, y, gridSize, gridSize);
}
void createDeadSquare(int x,int y)
{
        stroke(67);
          fill(11, 25, 44);

      rect(x, y, gridSize, gridSize);
}

//void DrawCells()
//{
//  String[] cells = SquarePosition.toArray(new String[0]);

//   for (int i = 0; i < cells.length; i++) {
//        // Get the string at index i
//        String cell = cells[i];       // e.g., "10,20"

//        // Split at the comma
//        String[] parts = cell.split(",");  // ["10", "20"]

//        // Convert to integers
//        int x = Integer.parseInt(parts[0]);
//        int y = Integer.parseInt(parts[1]);
//            fill(255,255,0);
//        rect(x,y,10,10);
//         fill(0);

//   }

//}
//yellow alive cell = FFFF00
//backgroud  = 0B192C
//grid 444444
//rules patterns and behaviour complex
