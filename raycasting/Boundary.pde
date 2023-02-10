class Boundary {
    PVector a;
    PVector b;

    Boundary(int x1, int y1, int x2, int y2) {
        a = new PVector(x1, y1);
        b = new PVector(x2, y2);
    }

    void show() {
        stroke(255);
        line(a.x, a.y, b.x, b.y);
    }
}