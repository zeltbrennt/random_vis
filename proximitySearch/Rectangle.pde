class Rectangle {
    
    int x;
    int y;
    int w;
    int h;
    
    Rectangle(int x, int y, int w, int h) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
    
    boolean contains(Point point) {
        return point.x >= x - w && point.x < x + w && point.y >= y - h && point.y < y + h;
    }
    
    boolean intesects(Rectangle other) {
        // rectangle is centered
        return !(x - w > other.x + other.w || 
            x + w < other.x - other.w || 
            y - h > other.y + other.h || 
            y + h < other.y - other.h); 
    }

    String toString() {
        return "center: (" + x + ", " + y + "), w: " + w + " h: " + h;
    }
}