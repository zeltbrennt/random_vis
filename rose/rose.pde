float radius;
float theta;
int maxIter;
ArrayList<Integer> primes;
float rotation;

ArrayList<Integer> getPrimes(int max) {
    ArrayList<Integer> primes = new ArrayList<Integer>();
    primes.add(2);
    for (int i = 3; i <= max; i += 2) {
        if (isPrime(i, primes)) primes.add(i);
    }
    return primes;
}

boolean isPrime(int number, ArrayList<Integer> primes) {
    for (int i = 0; i < sqrt(primes.size()); i++) {
        if (number % primes.get(i) == 0) return false; 
    }
    return true;
}

void setup() {
    size(1000, 1000);
    
    radius = 50;
    maxIter = 50;
    primes = getPrimes(maxIter);
    rotation = 0;
}

void draw() {
    background(0);
    translate(width / 2, height / 2);
    noFill();
    float x, y;
    rotation = (rotation + PI * 0.1) % TWO_PI;
    for (int k = 3; k < maxIter; k++) {
        stroke(185, 36, 41, 100);
        strokeWeight(1);
        circle(0, 0, radius * 2);
        strokeWeight(3);
        radius = radius / cos(PI / k);
        pushMatrix();
        if (primes.contains(k)) {
            strokeWeight(4);
            rotate(rotation/k);
        }
        rotate(k % 2 == 0 ? -rotation/k : 0);
        beginShape();
        for (int i = 0; i < k; i++) {
            theta = TWO_PI / k * i;
            x = radius * sin(theta);
            y = radius * - cos(theta);
            vertex(x, y);
        }
        endShape(CLOSE);
        
        popMatrix();
    
    }
    //noLoop();
    //saveFrame("/images/####.png");
    radius = 50;
}
