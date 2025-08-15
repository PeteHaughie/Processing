void setup() {
  background(0);
  size(420, 360);
  noFill();
  for (int i = 0; i < 360; i++) {
    stroke(i, i, i);
    line(0, i, width, i);
  }
}

void draw() {
  saveFrame("gradient.png");
  noLoop();
}
