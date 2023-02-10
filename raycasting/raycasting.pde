Boundary[] walls = new Boundary[5];
Particle particle;
int sceneW = 400;
int sceneH = 400;

void settings() {
    size(sceneW * 2, sceneH);
}

void setup() {
    particle = new Particle();
    for (int i = 0; i < 5; i++) {
        walls[i] = new Boundary(int(random(sceneW)), int(random(sceneH)), int(random(sceneW)), int(random(sceneH)));
    }
}

void draw() {
    
    background(0);
    stroke(255);
    line(sceneW, 0, sceneW, sceneH);

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
        float b = map(scene[i], 0, sceneW, 255, 0);
        float h = map(scene[i], 0, sceneW, sceneH, 0);
        fill(b);
        rectMode(CENTER);
        rect(i * w + w / 2, sceneH / 2, w, h);
    }
    popMatrix();
    
    
}