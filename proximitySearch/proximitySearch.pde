ArrayList<Point> points = new ArrayList<Point>();
QuadTree qt;

void setup() {
    size(800, 800);
    qt = new QuadTree(new Rectangle(width / 2, height / 2, width / 2, height / 2), 10);
    //for (int i = 0; i < points.length; i++) {
    //    points[i] = new Point(random(width), random(height));
    //    //qt.insert(points[i]);
    //}

}

void mousePressed() {
    Point p = new Point(mouseX, mouseY);
    points.add(p);
    qt.insert(p);
}

void draw() {
    background(0);
    fill(255);
    for (int i = 0; i < points.size(); i++) {
        points.get(i).show();
    }
    qt.show();
}