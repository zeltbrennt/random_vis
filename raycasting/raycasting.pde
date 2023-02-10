Boundary wall;
Ray ray;
Particle particle;

void setup() {
    size(400, 400);
    wall = new Boundary(300, 100, 300, 300);
    particle = new Particle();
}

void draw() {
    
    background(0);

    line(0, 0, 0, height);
    line(0, 0, width, 0);
    line(width-1, height-1, 0, height-1);
    line(width-1, height-1, width-1, 0);

    wall.show();
    particle.update(mouseX, mouseY);
    particle.show();
    particle.look(wall);

    
}