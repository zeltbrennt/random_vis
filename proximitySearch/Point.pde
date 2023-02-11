class Point {
    int x;
    int y;

    Point(float x, float y) {
        this.x = int(x);
        this.y = int(y);

    }

    Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    void show() {
        circle(x, y, 5);
    }

    void show(int i) {
        point(x, y);
        text(i, x, y, 12);
    }
}