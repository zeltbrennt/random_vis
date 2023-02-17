float rot;
float inc;
float phi, phi_frac;

void setup() {
    size(800,800);
    phi = 0.5 + sqrt(5) / 2;
    phi_frac = 1 / phi;
    rot = 1;
    noCursor();
}

void draw() {
    background(51, 0, 60);
    noStroke();
    
    
    inc = map(mouseX, 0, width, -0.0001, 0.0001);
    fill(100, 100);
    rect(mouseX < width / 2 ? mouseX : width / 2, height - 10, abs(width / 2 - mouseX), 10);
    pushMatrix();
    noStroke();
    translate(width / 2, height / 2);
    for (int i = 0; i < width / 2; i++) {
        fill(255 - i, 200, i, 150 - i / 4);
        circle(i, 0, map(sqrt(i), 1, 16, 5, 40));
        rotate(TWO_PI / rot);
    }
    popMatrix();
    fill(255);
    text(String.format("%.4f", rot), 0, height);
    if (rot > phi_frac && rot < phi) rot += inc;
    else if (rot < phi_frac && inc > 0) rot += inc;
    else if (rot > phi && inc < 0) rot += inc;
    //saveFrame("frames/####.png");
}
