float creal, cimag;
int depth;
float zreal, zimag;
float MIN_REAL = -2.2;
float MAX_REAL = 0.8;
float MIN_IMAG = -1.5;
float MAX_IMAG = 1.5;
float transX, transY;
color[] mandel;
fractalColor paint;

void setup() {
    size(800, 800);
    paint = new fractalColor();
    depth = 20;
    int mandelIter = 32;
    int infinity = 16;
    transX = 2 * width / 3;
    transY = height / 2;
    //create Mandelbrot-Set
    mandel = new color[width * height];
    for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
            float real = zreal = 0;
            float imag = zimag = 0;
            creal = map(x, 0, width, MIN_REAL, MAX_REAL);
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
/*
TODO:
    - implement zooming in
    - implement parallel julia set
*/

void draw() {
    //update background to Mandelbrot-Set
    pixelDensity(1);
    loadPixels();
    for (int i = 0; i < mandel.length; i++) pixels[i] = mandel[i];
    updatePixels();
    
    //get value for c and display at curser
    zreal = 0;
    zimag = 0;
    creal = map(mouseX, 0, width, MIN_REAL, MAX_REAL);
    cimag = map(mouseY, 0, height, MIN_IMAG, MAX_IMAG);
    fill(0, 150);
    stroke(0, 0);
    rect(mouseX + 8, mouseY, 85, 14, 14);
    fill(255, 255, 0);
    text(String.format("c = %.2f + %.2fi", creal, cimag), mouseX + 10, mouseY + 10);
    cursor(CROSS);
    
    //add coordinates
    stroke(55);
    translate(transX, transY);
    line(0, -height, 0, height);
    line( -width, 0, width, 0);
    stroke(255);
    noFill();
    
    //draw iterations of z
    float real, imag, vx, vy;
    beginShape();
    vertex(0, 0);
    for (int i = 0; i < depth; ++i) {
        real = zreal * zreal - zimag * zimag;
        imag = 2 * zreal * zimag;
        zreal = real + creal;
        zimag = imag + cimag;
        vx = map(zreal, MIN_REAL, MAX_REAL, -transX, transX / 2);
        vy = map(zimag, MIN_IMAG, MAX_IMAG, -transY, transY);
        stroke(250, 250, 0, 200);
        circle(vx, vy, 5);
        stroke(250, 200);
        vertex(vx, vy);
    }
    endShape();
    //saveFrame("images/####.png");
}
