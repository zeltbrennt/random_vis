float creal, cimag;
int depth;
float zreal, zimag;
float MIN_REAL = -2.5;
float MAX_REAL = 1;
float MIN_IMAG = -1.5;
float MAX_IMAG = 1.5;
float transX, transY;
color[] mandel;
fractalColor paint;
int mandelIter;
int infinity;
boolean showZ = true;
int windowSize;

void settings() {
    windowSize = 800;
    float d = (abs(MIN_REAL) + MAX_REAL) / (abs(MIN_IMAG) + MAX_IMAG);
    size(2 * windowSize, windowSize);
    depth = 20;
    mandelIter = 31;
    infinity = 7;
}

void makeMandelbrot() {
    for (int x = 0; x < width / 2; x++) {
        for (int y = 0; y < height; y++) {
            float real = zreal = 0;
            float imag = zimag = 0;
            creal = map(x, 0, width / 2, MIN_REAL, MAX_REAL);
            cimag = map(y, 0, height, MIN_IMAG, MAX_IMAG);
            int n = 0;
            while(n < mandelIter) {
                real = zreal * zreal - zimag * zimag;
                imag = 2 * zreal * zimag;
                zreal = real + creal;
                zimag = imag + cimag;
                if (zreal * zreal + zimag * zimag > infinity) break;
                n++;
            }
            mandel[x + y * width] = n == mandelIter ? color(10, 10,10) : paint.getColor(n % 16);
        }
    }
}

void makeJulia() {
    for(int x = 0; x < width / 2; x++) {
        for (int y = 0; y < height; y++) {
            float real = 0;
            float imag = 0;
            creal = map(mouseX, 0, width / 2, MIN_REAL, MAX_REAL);
            cimag = map(mouseY, 0, height, MIN_IMAG, MAX_IMAG);
            zreal = map(x, 0, width / 2, MIN_REAL + 0.75, MAX_REAL + 0.75);
            zimag = map(y, 0, height, MIN_IMAG, MAX_IMAG);
            int n = 0;
            while(n < mandelIter) {
                real = zreal * zreal - zimag * zimag;
                imag = 2 * zreal * zimag;
                zreal = real + creal;
                zimag = imag + cimag;
                if (zreal * zreal + zimag * zimag > infinity) break;
                n++;
            }
            mandel[x + y * width + windowSize] = n == mandelIter ? color(10, 10,10) : paint.getColor(n % 16);
        }
    }
    
}

void setup() {
    paint = new fractalColor();
    //create Mandelbrot-Set
    mandel = new color[width * height];
    makeMandelbrot();
}
/*
TODO:
- implement zooming in
- implement parallel julia set
*/

void keyPressed() {
    if (key == 'x') showZ = !showZ;
}

void draw() {



    //update background to Mandelbrot-Set
    pixelDensity(1);
    loadPixels();
    makeJulia();
    for (int i = 0; i < pixels.length; i++) pixels[i] = mandel[i];
    updatePixels();
    
    //get value for c and display at curser
    zreal = 0;
    zimag = 0;
    creal = map(min(mouseX, width / 2), 0, width / 2, MIN_REAL, MAX_REAL);
    cimag = map(mouseY, 0, height, MIN_IMAG, MAX_IMAG);
    fill(0, 150);
    stroke(0, 0);
    rect(min(mouseX + 8, width / 2), mouseY, 85, 14, 14);
    fill(255, 255, 0);
    text(String.format("c = %.2f %s %.2fi", creal, cimag < 0 ? "-" : "+", abs(cimag)), min(mouseX + 10, width / 2), mouseY + 10);
    cursor(CROSS);
    
    //add coordinates
    stroke(55);
    // in a variable....??
    line(map(MIN_REAL, MIN_REAL, MAX_REAL, 0, width / 2), map(0, MIN_IMAG, MAX_IMAG, 0, height), map(MAX_REAL, MIN_REAL, MAX_REAL, 0, width / 2), map(0, MIN_IMAG, MAX_IMAG, 0, height));
    line(map(0, MIN_REAL, MAX_REAL, 0, width / 2), map(MIN_IMAG, MIN_IMAG, MAX_IMAG, 0, height), map(0, MIN_REAL, MAX_REAL, 0, width / 2), map(MAX_IMAG, MIN_IMAG, MAX_IMAG, 0, height));
    
    stroke(255);
    //line(0, height /2, width, height / 2);
    //line(width / 2, 0, width / 2, height);
    noFill();
    
    //draw iterations of z
    float real, imag, vx, vy;
    beginShape();
    vertex(map(0, MIN_REAL, MAX_REAL, 0, width / 2),map(0, MIN_IMAG, MAX_IMAG, 0, height));
    for (int i = 0; i < depth && showZ; ++i) {
        real = zreal * zreal - zimag * zimag;
        imag = 2 * zreal * zimag;
        zreal = real + creal;
        zimag = imag + cimag;
        vx = map(zreal, MIN_REAL, MAX_REAL, 0, width / 2);
        vy = map(zimag, MIN_IMAG, MAX_IMAG, 0, height);
        if (zreal * zreal + zimag * zimag > infinity) break;
        stroke(250, 250, 0, 200);
        circle(vx, vy, 5);
        stroke(250, 200);
        vertex(vx, vy);
    }
    endShape();
    //saveFrame("images/####.png");
}
