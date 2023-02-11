class QuadTree {
    Rectangle root;
    int capacity;
    int size;
    Point[] points;
    QuadTree childNortWest;
    QuadTree childSouthWest;
    QuadTree childNortEast;
    QuadTree childSouthEast;
    boolean isLeaf;
    
    QuadTree(Rectangle root, int capacity) {
        this.root = root;
        this.capacity = capacity;
        points = new Point[capacity];
        size = 0;
        isLeaf = true;
    }
    
    boolean insert(Point point) {
        // don't inset, if not in bounds
        if (!root.contains(point)) return false;
        // only insert if not at capacity
        if (size < capacity) {
            points[size] = point;
            size++;
            return true;
        }
        if (isLeaf) subdivide();  
        if (childNortEast.insert(point)) return true;
        if (childNortWest.insert(point)) return true;
        if (childSouthEast.insert(point)) return true;
        if (childSouthWest.insert(point)) return true;
        return false;
    }
    
    void subdivide() {
        
        Rectangle ne = new Rectangle(root.x + root.w / 2, root.y - root.h / 2, root.w / 2, root.h / 2);
        Rectangle nw = new Rectangle(root.x - root.w / 2, root.y - root.h / 2, root.w / 2, root.h / 2);
        Rectangle se = new Rectangle(root.x + root.w / 2, root.y + root.h / 2, root.w / 2, root.h / 2);
        Rectangle sw = new Rectangle(root.x - root.w / 2, root.y + root.h / 2, root.w / 2, root.h / 2);
        childNortEast = new QuadTree(ne, capacity);
        childNortWest = new QuadTree(nw, capacity);
        childSouthEast = new QuadTree(se, capacity);
        childSouthWest = new QuadTree(sw, capacity);
        isLeaf = false;
        //push all points down to leaf-nodes
        for (Point p : points) {
            childNortEast.insert(p);
            childNortWest.insert(p);
            childSouthEast.insert(p); 
            childSouthWest.insert(p);
        }
        points = null;
    }
    
    ArrayList<Point> query(Rectangle area, ArrayList<Point> found) {
        if (!area.intesects(root)) return found;
        if (isLeaf) {
            for (Point p: points) if (p != null) found.add(p);
            return found;
        }
        childNortEast.query(area, found);
        childNortWest.query(area, found);
        childSouthEast.query(area, found);
        childSouthWest.query(area, found);
        return found;
    }

    ArrayList<Point> query(Rectangle area) {
        ArrayList<Point> found = new ArrayList<Point>();
        return query(area, found);
    }
    
    String toString() {
        return String.format("[size: %d/%d, NE: %s, NW: %s, SE: %s, SW: %s]\n", size, capacity, childNortEast, childNortWest, childSouthEast, childSouthWest);
    }
    
    void show() {
        stroke(100);
        fill(100, 20);
        rectMode(CENTER);
        rect(root.x, root.y, root.w * 2, root.h * 2);
        //fill(255);
        //text("(" + root.x + ", " + root.y + ")", root.x - root.w, root.y - root.h + 12);
        if (!isLeaf) {
            childNortEast.show();
            childNortWest.show();
            childSouthEast.show();
            childSouthWest.show();
        }
    }
}