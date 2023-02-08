import java.util.List;
import java.util.ArrayList;

class Cell {
  int i; //cols
  int j; //rows
  boolean[] walls;
  boolean visited;
  
  
  Cell(int i, int j) { 
    this.i = i;
    this.j =j;
    walls = new boolean[] {true, true, true, true};
    visited = false;
  }
  
  void show() {
    int x = i * w;
    int y = j * w;
    stroke(255);
    noFill();
    if (walls[0]) line(x, y, x+w, y);
    if (walls[1]) line(x, y, x, y+w);
    if (walls[2]) line(x+w, y+w, x, y+w);
    if (walls[3]) line(x+w, y+w, x+w, y);
    
    if (visited) {
      noStroke();
      fill(255, 0, 255, 100);
      rect(x, y, w, w);
    }
  }
  
  Cell checkNeighbors() {
    List<Cell> neighbors = new ArrayList<>(4);
    Cell top    = j - 1 >= 0   ? grid[i][j-1] : null;
    Cell left   = i - 1 >= 0   ? grid[i-1][j] : null;
    Cell bottom = j + 1 < rows ? grid[i][j+1] : null;
    Cell right  = i + 1 < cols ? grid[i+1][j] : null;
    
    if (top    != null && !top.visited)    neighbors.add(top);
    if (left   != null && !left.visited)   neighbors.add(left);
    if (bottom != null && !bottom.visited) neighbors.add(bottom);
    if (right  != null && !right.visited)  neighbors.add(right);
    if (neighbors.size() > 0) {
      int r = floor(random(0, neighbors.size()));
      return neighbors.get(r);
    } else return null;
  }
  
  void removeWalls(Cell next) {
    if (j > next.j) {
      walls[0] = false;
      next.walls[2] = false;
    }
    if (j < next.j) {
      walls[2] = false;
      next.walls[0] = false;
    }
    if (i > next.i) {
      walls[1] = false;
      next.walls[3] = false;
    }
    if (i < next.i) {
      walls[3] = false;
      next.walls[1] = false;
    }
  }
  
  void highlight() {
      noStroke();
      fill(0, 0, 255, 100);
      rect(i * w, j * w, w, w);
  }
}
