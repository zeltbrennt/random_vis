class Ray {
    PVector pos;
    PVector dir;
    
    Ray(int x, int y) {
        pos = new PVector(x, y);
        dir = new PVector(1, 0);
    }

    void lookAt(float x, float y) {
        dir.x = x - pos.x;
        dir.y = y - pos.y;
        dir.normalize();
    }
    
    void show() {
        stroke(255);
        pushMatrix();
        translate(pos.x, pos.y);
        line(0, 0, dir.x * 10, dir.y * 10); //for showing  alitte biggeer
        popMatrix();
    }
    
    PVector cast(Boundary wall) {
        // start and endpoints of the wall
        float x1 = wall.a.x;
        float y1 = wall.a.y;
        float x2 = wall.b.x;
        float y2 = wall.b.y;
        // start and end of the ray
        float x3 = pos.x;
        float y3 = pos.y;
        float x4 = pos.x + dir.x;
        float y4 = pos.y + dir.y;
        
        float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
        if (den == 0) return null;
        float nom1 = (x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4);
        float nom2 = (x1 - x2) * (y1 - y3)  - (y1 - y2) * (x1 - x3);
        float t = nom1 / den;
        float u = -nom2 / den;
        if (t > 0 && t < 1 && u > 0) {
            return new PVector(x1 + t * (x2 - x1), y1 + t * (y2 - y1));
        }
        return null; 
    }
}