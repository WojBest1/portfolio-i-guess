class Cell {

  PVector Position;
  boolean Mazevisited = false;

  boolean top = true;
  boolean right = true;
  boolean bottom = true;
  boolean left = true;
  
 // A* values
  float gCost = 0;
  float hCost = 0;
  float fCost = 0;

  Cell parent = null;   // previous cell in the path

  boolean AStarVisited = false; // A* visited/checked

  Cell(PVector Position) {
     this.Position = Position;
  }
}
import java.util.Stack;

Stack<PVector> VisitedNodes = new Stack<PVector>();

int cubeDimensions = 10;
float cubeSpacing = cubeDimensions/2;


PVector[] directions = {new PVector(0,1 * cubeDimensions),new PVector(1 * cubeDimensions,0),new PVector(0,-1 * cubeDimensions),new PVector(-1 * cubeDimensions,0)};

PVector rand;
Cell[][] grid;

void setup() {

background(255);

     frameRate(10000);    
     size(500,500);
int cols = width / cubeDimensions;
int rows = height / cubeDimensions;

grid = new Cell[cols][rows];

drawGrid();

 rand = randomGrid();




}
boolean DeadEnd(PVector TestPoint)
{


  for(int i = 0; i < directions.length;i++)
  {
 PVector newPoint = PVector.add(TestPoint, directions[i]); 
  
  if (!(
  newPoint.x < 0 ||
  newPoint.x >= width ||
  newPoint.y < 0 ||
  newPoint.y >= height ||
  grid[(int)newPoint.x / cubeDimensions][(int)newPoint.y / cubeDimensions] == null ||
   grid[(int)newPoint.x / cubeDimensions][(int)newPoint.y / cubeDimensions].Mazevisited
  ))
  {
     return false;
  }
  }
  
  return true;
}
boolean Finished = false;
boolean Stop = false;
void draw() {
  
  if(!Finished)
  {
    GenerateMaze();
  }
  else if(point1 != null && point2 != null&& Stop == false)
  {
    AStarAlgorithm();
    println("run");

  }


 

}
PVector point1;
PVector point2;
PVector DrawRect(int colour)
{
   float x = (int)mouseX / cubeDimensions * cubeDimensions + cubeSpacing ;
  float y = (int)mouseY/ cubeDimensions * cubeDimensions + cubeSpacing;
  fill(colour);
  rect(x, y, cubeDimensions, cubeDimensions);
  return new PVector(x,y);
}

Cell CurrentPoint;

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    point1 = DrawRect(50);
    CurrentPoint = getPointFromGrid(point1);
  
    NotVisited.add(CurrentPoint);
  }

  if (mouseButton == RIGHT)
  {

    
    point2 = DrawRect(128);
    
            CurrentPoint.gCost = 0;
    CurrentPoint.hCost = abs(CurrentPoint.Position.x - point2.x) / cubeDimensions +
                         abs(CurrentPoint.Position.y - point2.y) / cubeDimensions;
    CurrentPoint.fCost = CurrentPoint.gCost + CurrentPoint.hCost;
  }
}

ArrayList<Cell> NotVisited = new ArrayList<Cell>();
ArrayList<Cell> Visited = new ArrayList<Cell>();
void drawPath(Cell target)
{
    Stop = true;
    Cell current = target;

    stroke(0, 0, 255);
    strokeWeight(3);

    while (current != null && current.parent != null)
    {
        line(
            current.Position.x,
            current.Position.y,
            current.parent.Position.x,
            current.parent.Position.y
        );

        current = current.parent;
    }
}
void AStarAlgorithm()
{
  
   Cell lowest = NotVisited.get(0); //<>//

  for (Cell c : NotVisited)
  {
if (c.AStarVisited == false &&
   (c.fCost < lowest.fCost ||
   (c.fCost == lowest.fCost && c.hCost < lowest.hCost)))
    {
      lowest = c;
    }
  }  

      
    NotVisited.remove(lowest);
  Visited.add(lowest);

  lowest.AStarVisited = true;
  CurrentPoint = lowest;
  
  if (CurrentPoint == getPointFromGrid(point2))
    {
      drawPath(CurrentPoint);
      noLoop();
      return;
    }
  

  for (int i = 0; i < directions.length; i++)
  {
    PVector neighbourPos = PVector.add(CurrentPoint.Position, directions[i]);
    Cell neighbour = getPointFromGrid(neighbourPos);
      
      if (neighbour == null || hasWall(CurrentPoint, neighbour))
        continue;
      
      if (neighbour.AStarVisited)
        continue;
        
      
  if (!NotVisited.contains(neighbour))
  {
    neighbour.parent = CurrentPoint;
    updateCostsForNode(neighbour);
    NotVisited.add(neighbour);
  }
  else if (updateCostsForNode(neighbour))
  {
    neighbour.parent = CurrentPoint;
  }
  }

 


  
   rectMode(CENTER);
  noStroke();

  // Red = unexplored (open list)
  fill(255, 0, 0);
  for (Cell c : NotVisited)
  {
    rect(c.Position.x, c.Position.y, cubeSpacing, cubeSpacing);
  }

  // Green = explored (closed list)
  fill(0, 255, 0);
  for (Cell c : Visited)
  {
    rect(c.Position.x, c.Position.y, cubeSpacing, cubeSpacing);
  }
  
}
boolean hasWall(Cell a, Cell b)
{
  // b is to the right
  if (b.Position.x > a.Position.x)
    return a.right;

  // b is to the left
  if (b.Position.x < a.Position.x)
    return a.left;

  // b is below
  if (b.Position.y > a.Position.y)
    return a.bottom;

  // b is above
  if (b.Position.y < a.Position.y)
    return a.top;

  // Same cell
  return false;
}
boolean updateCostsForNode(Cell currentCell)
{
  float newG = CurrentPoint.gCost + cubeDimensions;

  if (newG >= currentCell.gCost)
    return false;

  currentCell.gCost = newG;

  currentCell.hCost = abs(currentCell.Position.x - point2.x) / cubeDimensions +
                      abs(currentCell.Position.y - point2.y) / cubeDimensions;

  currentCell.fCost = currentCell.gCost + currentCell.hCost;



  return true;
}
Cell getPointFromGrid(PVector point)
{
  int x = (int)point.x / cubeDimensions;
  int y = (int)point.y / cubeDimensions;

  if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length)
    return null;

  return grid[x][y];
}
void GenerateMaze()
{

  
 PVector newPoint;
int randomNeighbour;



if (!DeadEnd(rand))
{
    VisitedNodes.push(rand);
    
     randomNeighbour = (int)random(4);
    newPoint = PVector.add(rand, directions[randomNeighbour]);

    while (
      newPoint.x < 0 ||
      newPoint.x >= width ||
      newPoint.y < 0 ||
      newPoint.y >= height ||
      grid[(int)newPoint.x / cubeDimensions][(int)newPoint.y / cubeDimensions].Mazevisited
    )
    {
      randomNeighbour = (int)random(4);
      newPoint = PVector.add(rand, directions[randomNeighbour]);
    }

    drawWallRemove(getPointFromGrid(newPoint), getPointFromGrid(rand));
    rand = newPoint;
    grid[(int)rand.x / cubeDimensions][(int)rand.y / cubeDimensions].Mazevisited = true;
}
else if (!VisitedNodes.empty())
{
    rand = VisitedNodes.pop();
}
if (VisitedNodes.empty())
{
    Finished =true;
}
  
}
void drawGrid()
{
  for(int x = 0; x < grid.length; x++)
  {
    for(int y = 0; y < grid[x].length; y++)
    {
      grid[x][y] = new Cell(
        new PVector(
          x * cubeDimensions + cubeSpacing,
          y * cubeDimensions + cubeSpacing
        )
      );
    }
  }

  for (int x = 0; x <= grid.length; x++)
  {
    line(x * cubeDimensions, 0, x * cubeDimensions, height);
  }

  for (int y = 0; y <= grid[0].length; y++)
  {
    line(0, y * cubeDimensions, width, y * cubeDimensions);
  }
}

PVector randomGrid()
{
  float x = (int)random(width / cubeDimensions) * cubeDimensions + cubeSpacing;
  float y = (int)random(height / cubeDimensions) * cubeDimensions + cubeSpacing;

  return new PVector(x, y);
}


void drawWallRemove(Cell a, Cell b)
{
  PVector mid = PVector.add(a.Position, b.Position);
  mid.div(2);

  // Update wall data
  if (a.Position.x < b.Position.x) // b is to the right
  {
    a.right = false;
    b.left = false;
  }
  else if (a.Position.x > b.Position.x) // b is to the left
  {
    a.left = false;
    b.right = false;
  }
  else if (a.Position.y < b.Position.y) // b is below
  {
    a.bottom = false;
    b.top = false;
  }
  else if (a.Position.y > b.Position.y) // b is above
  {
    a.top = false;
    b.bottom = false;
  }

  // Erase the wall visually
  rectMode(CENTER);
  fill(255);
  noStroke();

  if (a.Position.x != b.Position.x)
  {
    // Vertical wall
    rect(mid.x, mid.y, cubeSpacing, cubeDimensions - 1.5);
  }
  else
  {
    // Horizontal wall
    rect(mid.x, mid.y, cubeDimensions - 1.5, cubeSpacing);
  }
}
