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
        circle(x, y, 4);
        //text("(" + x + ", " + y + ")", x, y, 5);
    }


    void show(color c) {
        fill(c);
        circle(x, y, 4);
        //text("(" + x + ", " + y + ")", x, y, 5);
    }

    String toString() {
        return "(" + x + ", " + y + ")";
    }
}