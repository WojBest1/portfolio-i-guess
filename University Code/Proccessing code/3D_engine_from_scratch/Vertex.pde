class Vertex
{
 PVector Position;
 PVector UVcoords;
 
Vertex(PVector Position,PVector UVcoords)
{
  this.Position = Position;
  this.UVcoords = UVcoords;
  
}
  Vertex copy() {
    // Position.copy() and UV.copy() are built-in for PVectors
    return new Vertex(Position.copy(), UVcoords.copy());
  }
  
  
}
