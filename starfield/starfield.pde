int nStars = 800;
float speed;

Star[] stars = new Star[nStars];

void setup() {
  size(800, 400);
  //fullScreen();
  for (int i = 0; i < nStars; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  speed = map(mouseX, 0, width, 0, 50);
  background(0);
  translate(width/2, height / 2);
  for (Star s : stars) {
    s.update();
    s.show();
  }
  saveFrame("images/####.png");
}
