import java.util.Arrays;
boolean defaultX, showIterations;

color[] background;

void setup() {
    //size(800, 400);
    fullScreen();
    background = makeFeigenbaum();
    defaultX = false;
    showIterations = false;
    noCursor();
}

void draw() {
    //background
    pixelDensity(1);
    loadPixels();
    for (int i = 0; i < pixels.length; i++) pixels[i] = background[i];
    updatePixels();
    fill(showIterations ? #638918 : #c8c8c8);
    text(String.format("iterations %s", showIterations ? "ON" : "OFF"), 5, 10, 10);
    fill(defaultX ? #638918 : #c8c8c8);
    text(String.format("default x0 %s", defaultX ? "ON" : "OFF"), 5, 20, 10);
    if (showIterations) drawIterations();
    //saveFrame("frames/####.png");
}

color[] makeFeigenbaum() {
    color[] feigenbaum = new color[width * height];
    Arrays.fill(feigenbaum, #003049);
    int pixelX;
    for (float r = 2.4; r <= 4; r += 0.0001) {
        float x = 0.5;
        pixelX = int(map(r, 2.4, 4, 0, width));
        for (int i = 0; i < 100; i++) {
            x = r * x * (1 - x);
            if (i > 70) feigenbaum[pixelX + int(map(x, 0, 1, height, 0)) * width] = color(200);
        }
    }
    return feigenbaum;
}

void keyPressed() {
    if (key == 'i') showIterations = !showIterations;
    else if (key == 'x') defaultX = !defaultX;
}

void drawIterations() {
    int plotWidth = width / 4;
    int plotHeight = height / 4;
    float x = defaultX ? 0.5 : map(mouseY, -1, height, 1, 0);
    float r = map(mouseX, 0, width, 2.4, 4);
    fill(200);
    text(String.format("r = %.4f", r), mouseX + 10, height - 5, 10);
    stroke(#638918);
    fill(200);
    line(mouseX, 0, mouseX, height);
    if (!defaultX) {
        line(mouseX - 5, mouseY, mouseX + 5, mouseY);
        text(String.format("x0 = %.3f", x), mouseX + 10, mouseY+4);
    }
    //population-plot
    noStroke();
    translate(width / 20, 2 * height / 3);
    rect(0, 0, plotWidth, plotHeight, 10);
    translate(10, 10);
    stroke(150);
    line(0, 0, 0, plotHeight -20);
    line(0, plotHeight -20, plotWidth - 20, plotHeight -20);
    beginShape();
    noFill();
    stroke(51);
    vertex(map(0, 0, 100, 0, plotWidth -20), map(x, 1, 0, 0, plotHeight- 20));
    for (int i = 1; i < 100; i++) {
            x = r * x * (1 - x);
            vertex(map(i, 0, 100, 0, plotWidth - 20), map(x, 1, 0, 0, plotHeight - 20));
    }
    endShape();
    fill(50);
    text("population", 5, 10);
    text("iteration", plotWidth - 70, plotHeight - 25);
}
