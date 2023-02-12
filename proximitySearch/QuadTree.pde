class QuadTree {
    Rectangle root;
    int capacity;
    int size;
    Point[] points;
    QuadTree childNortWest;
    QuadTree childNortEast;
    QuadTree childSouthWest;
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
        if (size < capacity || root.w == 1 || root.h == 1) {
            points[size] = point;
            size++;
            return true;
        }
        if (isLeaf) subdivide();  
        if (childNortWest.insert(point)) return true;
        if (childNortEast.insert(point)) return true;
        if (childSouthEast.insert(point)) return true;
        if (childSouthWest.insert(point)) return true;
        return false;
    }
    
    void subdivide() {
        
        int childWidth = root.w / 2;
        int childHeight = root.h / 2;
        boolean oddWidth = root.w % 2 != 0;
        boolean oddHeight = root.h % 2 != 0;
        Rectangle nw = new Rectangle(root.x - childWidth, root.y - childHeight, oddWidth ? childWidth + 1 : childWidth, oddHeight ? childHeight + 1 : childHeight);
        Rectangle ne = new Rectangle(root.x + (oddWidth ? childWidth + 1 : childWidth), root.y - childHeight, childWidth, oddHeight ? childHeight + 1 : childHeight);
        Rectangle se = new Rectangle(root.x + (oddWidth ? childWidth + 1 : childWidth), root.y + (oddHeight ? childHeight + 1 : childHeight), childWidth, childHeight);
        Rectangle sw = new Rectangle(root.x - childWidth, root.y + (oddHeight ? childHeight + 1 : childHeight), oddWidth ? childWidth + 1 : childWidth, childHeight);
        childNortWest = new QuadTree(nw, capacity);
        childNortEast = new QuadTree(ne, capacity);
        childSouthEast = new QuadTree(se, capacity);
        childSouthWest = new QuadTree(sw, capacity);
        isLeaf = false;
        //push all points down to leaf-nodes
        for (Point p : points) {
            childNortWest.insert(p);
            childNortEast.insert(p);
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
        childNortWest.query(area, found);
        childNortEast.query(area, found);
        childSouthEast.query(area, found);
        childSouthWest.query(area, found);
        return found;
    }

    ArrayList<Point> query(Rectangle area) {
        ArrayList<Point> found = new ArrayList<Point>();
        return query(area, found);
    }
    
    String toString() {
        if (isLeaf) return "(" + size +"/"+capacity + ")" ;
        else return "[" + childNortWest.toString() + childNortEast.toString()  + childSouthEast.toString() + childSouthWest.toString() + "]";
    }
    
    void show() {
        stroke(100);
        fill(100, 5);
        rectMode(CENTER);
        rect(root.x, root.y, root.w * 2, root.h * 2);
        //fill(255);
        //text("(" + root.x + ", " + root.y + ")", root.x - root.w, root.y + root.h);
        if (!isLeaf) {
            childNortWest.show();
            childNortEast.show();
            childSouthEast.show();
            childSouthWest.show();
        }
    }
}