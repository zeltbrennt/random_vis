Boundary wall;
Ray ray;

void setup() {
    size(400, 400);
    wall = new Boundary(300, 100, 300, 300);
    ray = new Ray(100, 200);
}

void draw() {
    background(0);
    wall.show();
    ray.show();
    ray.lookAt(mouseX, mouseY);

    PVector pt = ray.cast(wall);
    if (pt != null) {
        fill(255);
        circle(pt.x, pt.y, 10);
    }
}