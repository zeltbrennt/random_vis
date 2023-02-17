int scale;
float rotX, rotY, camX, camY, camZ;

void setup() {
  size(400, 400, P3D);
  scale = 100;
}

void draw() {

  //camera controls
  translate(camX, camY, camZ);
  translate(width/2.0-camX, height/2.0-camY);
  rotateY(rotY);
  rotateX(rotX);
  translate(-(width/2.0-camX), -(height/2.0-camY));

  // things on screen
  lights();
  background(51);
  stroke(250);
  fill(200);
  box(scale);
  translate(scale, 0);
  fill(150);
  box(scale);
  translate(0, scale);
  fill(100);
  box(scale);
  translate(0, -scale, scale);
  fill(50);
  box(scale);
   
}


void mouseDragged() {
  if (mouseButton == LEFT)  {
    rotY += (pmouseX - mouseX)*0.01;
    rotX += (pmouseY - mouseY)*0.01;
  }
  if (mouseButton == RIGHT) {
    camX -= (pmouseX - mouseX);
    camY -= (pmouseY - mouseY);
  }
  if (mouseButton == CENTER) {
    camZ += (pmouseY - mouseY);
  }
}
