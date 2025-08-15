class Particle extends PVector {
  float x, y;
  float speed;
  
  Particle() {
    x = random(-1, 1);
    y = random(-1, 1);
    speed = 0.035;
  }
}
