float phase = 0;

void setup() {
  size(200, 200);
}

void draw() {
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      float x = map(noise((i * 0.005) + phase, j * 0.005), 0, 1, -200, 200);
      float y = map(noise((i * 0.005) + phase, j * 0.005), 0, 1, -200, 200);
      color c = floor(map(noise((i * 0.005) + phase, (j * 0.005)), 0, 1, 0, 255));
      stroke(c);
      point(i, j);
      println(x, y);
    }
  }
  phase += 0.01;
}
