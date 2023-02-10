class Particle {
    
    PVector pos;
    Ray[] rays;
    int fov = 40;
    int res = 1;
    float heading;
    
    Particle() {
        pos = new PVector(sceneH / 2, sceneW / 2); // make it move 
        rays = new Ray[fov / res];
        heading = 0;
        for (int i = 0; i < rays.length; i++) {
            rays[i] = new Ray(pos, radians( - fov / 2 + i * res));
        }
    }
    
    void show() {
        fill(255);
        circle(pos.x, pos.y, 5);
        for (Ray r : rays) {
            r.show();
        }
    }
    
    void rotate(float angle) {
        heading += angle;
        for (int i = 0; i < rays.length; i++) {
            rays[i].setAngle(radians(-fov / 2 + i) + heading);
        }
    }
    
    void move(int step) {
        PVector vel = PVector.fromAngle(heading);
        pos.add(vel);
        }
    
    float[] look(Boundary[] walls) {
        float[] scene = new float[fov];
        for (int i = 0; i < rays.length; i++) {
            float minDist = 2 << 16;
            PVector closest = null;
            for (Boundary wall : walls) {
                PVector pt = rays[i].cast(wall);
                if (pt != null) {
                    float dist = PVector.dist(pos, pt);
                    if (dist < minDist) {
                        minDist = dist;
                        closest = pt;
                    }
                }
            }
            stroke(255, 100);
            scene[i] = minDist;
            if (closest != null) line(pos.x, pos.y, closest.x, closest.y);
        } 
        return scene;
    }
    
    void update(int x, int y) {
        pos.x = x;
        pos.y = y;
    }
}