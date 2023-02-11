ArrayList<Point> points = new ArrayList<Point>();
QuadTree qt;

void setup() {
    size(800, 800);
    qt = new QuadTree(new Rectangle(width / 2, height / 2, width / 2, height / 2), 4);
    for (int i = 0; i < 300; i++) {
        float x = width/ 2 + randomGaussian() * width / 8;
        float y = height / 2 + randomGaussian() * height / 8;
        Point p = new Point(x, y);
        points.add(p);
        qt.insert(p);
    }

}

void draw() {
    background(0);
    pushMatrix();
    fill(255);
    stroke(255);
    for (int i = 0; i < points.size(); i++) {
        points.get(i).show();
    }
    qt.show();
    popMatrix();

    int x = mouseX;
    int y = mouseY;
    Rectangle searchBox = new Rectangle(x, y, 50, 40);
    stroke(0, 255, 0);
    rectMode(CENTER);
    //fill(255, 255, 0);
    //text("(" + x + ", " + y + ")", x, y, 10);
    fill(0, 255, 0, 30);
    rect(searchBox.x, searchBox.y, searchBox.w * 2, searchBox.h * 2);
    line(0, searchBox.y, searchBox.x - searchBox.w, searchBox.y);
    line(searchBox.x + searchBox.w, searchBox.y, width, searchBox.y);
    line(searchBox.x, 0, searchBox.x, searchBox.y - searchBox.h);
    line(searchBox.x, searchBox.y + searchBox.h, searchBox.x, height);
    noStroke();
    ArrayList<Point> result = qt.query(searchBox);
    for (Point p : result) {
        if (searchBox.contains(p)) p.show(color(0, 255, 0));
        else p.show(color(255, 0, 0));
    }
    //println(result.size());
}