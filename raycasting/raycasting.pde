Boundary[] walls = new Boundary[5 + 4];
Particle particle;
int sceneW = 400;
int sceneH = 400;

void settings() {
    size(sceneW * 2, sceneH);
}

void setup() {
    particle = new Particle();
    for (int i = 0; i < walls.length; i++) {
        if (i == 0) walls[i] = new Boundary(0, 0, sceneW-1, 0);
        else if (i == 1) walls[i] = new Boundary(0, 0, 0, sceneH-1);
        else if (i == 2) walls[i] = new Boundary(sceneW-1, sceneH-1, 0, sceneH-1);
        else if (i == 3) walls[i] = new Boundary(sceneW-1, sceneH-1, sceneW-1, 0);
        else walls[i] = new Boundary(int(random(sceneW)), int(random(sceneH)), int(random(sceneW)), int(random(sceneH)));
    }
}

void keyPressed() { //key is down
    if (key == 'a') particle.rotate(-0.1);
    else if (key == 'd') particle.rotate(0.1);
    else if (key == 'w') particle.move(10);
    else if (key == 's') particle.move(-10);
}

void draw() {
    
    background(0);
    // cast rays to visible walls
    for (Boundary wall : walls) wall.show(); 
    particle.update(min(mouseX, sceneW), mouseY);
    particle.show();
    
    // render visible scene
    float[] scene = particle.look(walls);
    int w = sceneW / scene.length;
    pushMatrix();
    translate(sceneW, 0);
    for (int i = 0; i < scene.length; i++) {
        noStroke();
        float b = map(scene[i] * scene[i], 0, sceneW * sceneW, 255, 0);
        float h = map(scene[i], 0, sceneW, sceneH, 0);
        fill(b);
        rectMode(CENTER);
        rect(i * w + w / 2, sceneH / 2, w, h);
    }
    popMatrix();
    
    saveFrame("images/####.png");
}