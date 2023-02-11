class Rectangle {

    int x;
    int y;
    int width;
    int height;

    Rectangle(int x, int y, int width, int height) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }

    boolean contains(Point point) {
        return point.x >= x - width && point.x < x + width && point.y >= y - height && point.y < y + height;
    }
}