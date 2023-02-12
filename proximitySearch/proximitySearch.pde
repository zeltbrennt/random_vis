ArrayList<Point> points = new ArrayList<Point>();
QuadTree qt;
boolean showTree;
boolean showSearch;
boolean showPoints;

void setup() {
    size(800, 800);
    showTree = false;
    showSearch = false;
    showPoints = true;
    int numPoints = 10000;
    qt = new QuadTree(new Rectangle(width / 2, height / 2, width / 2, height / 2), numPoints / 1000);
    
    for (int i = 0; i < numPoints; i++) {
        float x = width / 2 + randomGaussian() * width / 6;
        float y = height / 2 + randomGaussian() * height / 6;
        Point p = new Point(x, y);
        points.add(p);
        qt.insert(p);
    }
}

void keyPressed() {
    if (key == 'q') showTree = !showTree;
    else if (key == 's') showSearch = !showSearch;
    else if (key == 'a') showPoints = !showPoints;
}

void draw() {
    background(0);
    noCursor();
    fill(255, 100);
    if (showPoints) {
        for (int i = 0; i < points.size(); i++) {
            points.get(i).show();
        } 
    }
    if (showTree) qt.show();
    
    
    int x = mouseX;
    int y = mouseY;
    Rectangle searchBox = new Rectangle(x, y, 40, 25);
    stroke(0, 255, 0);
    rectMode(CENTER);
    //fill(255, 255, 0);
    //text("(" + x + ", " + y + ")", x, y, 10);
    fill(0, 255, 0, 20);
    rect(searchBox.x, searchBox.y, searchBox.w * 2, searchBox.h * 2);
    line(0, searchBox.y, searchBox.x - searchBox.w, searchBox.y);
    line(searchBox.x + searchBox.w, searchBox.y, width, searchBox.y);
    line(searchBox.x, 0, searchBox.x, searchBox.y - searchBox.h);
    line(searchBox.x, searchBox.y + searchBox.h, searchBox.x, height);
    noStroke();
    ArrayList<Point> result = qt.query(searchBox);
    int found = 0;
    for (Point p : result) {
        if (searchBox.contains(p)) {
            p.show(color(0, 255, 0));
            found++;
        }
        else if (showSearch) p.show(color(255, 0, 0));
    }
    fill(0, 255, 0);
    textAlign(LEFT);
    text("total points:    " + points.size(), 0, 10);
    text("points checked:  " + result.size(), 0, 20);
    text("points found:    " + found, 0, 30);
    textAlign(RIGHT);
    if (showPoints) {
        fill(0, 250, 0);  
        text("points visible", width, 10);
    } else {
        fill(150);
        text("points hidden", width, 10);
    }
    if (showSearch) {
        fill(0, 250, 0);  
        text("checks visible", width, 20);
    } else {
        fill(150);
        text("checks hidden", width, 20);
    }
    if (showTree) {
        fill(0, 250, 0);  
        text("quadtree visible", width, 30);
    } else {
        fill(150);
        text("quadtree hidden", width, 30);
    }
    text("FPS: " + int(frameRate), width, height);
    //println(qt);
    
}