import java.util.Deque;
import java.util.ArrayDeque;

int rows, cols;
int w = 20;
Cell[][] grid;
Cell current;
Deque<Cell> stack;

void setup() {
  size(301, 601);
  cols = floor(width / w);
  rows = floor(height / w);
  grid = new Cell[cols][rows];
  for(int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      grid[i][j] = new Cell(i, j) ;
    }
  }
  current = grid[0][0];
  stack = new ArrayDeque<>();
}

void draw() {
  background(51);
  for(int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
     grid[i][j].show();
    }
  }
  
  current.visited = true;
  current.highlight();
  Cell next = current.checkNeighbors();
  if (next != null) {
    next.visited = true;
    stack.addFirst(current);
    current.removeWalls(next);
    current = next;
  } else if (!stack.isEmpty()) {
    current = stack.removeFirst();
  } else noLoop();
  saveFrame("frames/####.png");
}
