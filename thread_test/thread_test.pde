void setup() {
  size(200, 200, P2D);
  background(0);
}

void draw() {
  thread("saveImage");
}

void saveImage() {
  saveFrame("output/" + frameCount + ".png");
}
