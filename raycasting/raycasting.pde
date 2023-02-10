Boundary[] walls = new Boundary[5];
Particle particle;

void setup() {
    size(400, 400);
    particle = new Particle();
    for (int i = 0; i < 5; i++) {
        walls[i] = new Boundary(int(random(width)), int(random(height)), int(random(width)), int(random(height)));
    }
}

void draw() {
    
    background(0);
    /*
    line(0, 0, 0, height);
    line(0, 0, width, 0);
    line(width-1, height-1, 0, height-1);
    line(width-1, height-1, width-1, 0);
    */
    for (Boundary wall : walls) {
        wall.show();
    }
    particle.update(mouseX, mouseY);
    particle.show();
    particle.look(walls);
    
    
}