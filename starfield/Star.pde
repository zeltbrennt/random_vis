class Star {
  float x;
  float y;
  float z;
  
  Star() {
    this.x = random(-width/4, width/4);
    this.y = random(-height/4, height/4);
    this.z = random(width);
  }
  
  void update() {
    z = z - speed;
    z = z < 1 ? width : z;
  }
  
  void show() {
    fill(255);
    noStroke();
    
    float sx = map( x / z, 0, 1, 0, width);
    float sy = map( y / z, 0, 1, 0, width);
    float r = map(z, 0, width, 6, 0);
    
    ellipse(sx, sy, r, r);
  }
  
}
