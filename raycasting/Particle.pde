class Particle {

    PVector pos;
    Ray[] rays;
    int fov = 360;
    int res = 10;

    Particle() {
        pos = new PVector(200, 200); // make it move 
        rays = new Ray[fov / res];
        for (int i = 0; i < rays.length; i++) {
            rays[i] = new Ray(pos, radians(i * res));
        }
    }

    void show() {
        fill(255);
        circle(pos.x, pos.y, 5);
        for (Ray r : rays) {
            r.show();
        }
    }

    void look(Boundary wall) {
        for (Ray ray : rays) {
            PVector pt = ray.cast(wall);
            if (pt != null) {
                line(pos.x, pos.y, pt.x, pt.y);
            }
        } 
    }

    void update(int x, int y) {
        pos.x = x;
        pos.y = y;
    }
}