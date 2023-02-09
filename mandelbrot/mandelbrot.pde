float creal, cimag;
int depth;
float zreal, zimag;
float MIN_REAL = -2.2;
float MAX_REAL = 0.7;
float MIN_IMAG = -1.2;
float MAX_IMAG = 1.2;
float transX, transY;
color[] mandel;
fractalColor paint;

void setup() {
    size(800, 600);
    paint = new fractalColor();
    depth = 10;
    int mandelIter = 32;
    int infinity = 16;
    transX = 2 * width / 3;
    transY = height / 2;
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
            if (n == mandelIter) {
                mandel[x + y * width] = color(10, 10,10);
            } else {

                mandel[x + y * width] = paint.getColor(n % 16);
            }
        }
    }
}

void draw() {
    pixelDensity(1);
    loadPixels();
    for (int i = 0; i < mandel.length; i++) {
        pixels[i] = mandel[i];
    }
    updatePixels();
    
    zreal = 0;
    zimag = 0;
    creal = map(mouseX, 0, width, MIN_REAL, MAX_REAL);
    cimag = map(mouseY, 0, height, MIN_IMAG, MAX_IMAG);
    
    
    stroke(55);
    translate(2 * width / 3, height / 2);
    line(0, -height, 0, height);
    line( -width, 0, width, 0);
    stroke(200, 150, 0);
    noFill();
    beginShape();
    float real, imag, vx, vy;
    stroke(255);
    vertex(0, 0);
    for (int i = 0; i < depth; ++i) {
        real = zreal * zreal - zimag * zimag;
        imag = 2 * zreal * zimag;
        zreal = real + creal;
        zimag = imag + cimag;
        vx = map(zreal, MIN_REAL, MAX_REAL, -transX, transX / 2);
        vy = map(zimag, MIN_IMAG, MAX_IMAG, -transY, transY);
        if (i==0) stroke(255, 255, 0);
        else stroke(255);
        circle(vx, vy, 5);
        vertex(vx, vy);
    }
    endShape();
    //saveFrame("images/####.png");
}
