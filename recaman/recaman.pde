import processing.svg.*;

int maxIter;
int scale;

void setup() {
    size(1040, 1040);
    scale = 5;
    maxIter = 100;
    noLoop();
    beginRecord(SVG, "recaman.svg");
}

void draw() {
    background(#317773);
    stroke(#E2D1F9);
    strokeWeight(2);
    noFill();
    translate(100, height - 100);
    rotate( -PI / 4);
    line(0, 0, -width * 2, 0);
    int scale = 5;
    int rec = 0;
    float arc = 0;
    ArrayList<Integer> seq = new ArrayList<>(maxIter);
    for (int i = 0; i <= maxIter; i++) {
        boolean turn = i % 2 != 0;
        if (rec - i < 0 || seq.contains(rec - i)) {
            arc = rec + i - (rec + i - rec) / 2.0;
            rec += i;
        }
        else {
            arc = rec - (rec - (rec - i)) / 2.0;
            rec -= i;
        }
        arc(arc * scale, 0, i * scale, i * scale, turn ? 0 : PI, turn ? PI : TWO_PI, OPEN);
        seq.add(rec);
    }
    line(rec * scale, 0,width * 2, 0);
    endRecord();
}
