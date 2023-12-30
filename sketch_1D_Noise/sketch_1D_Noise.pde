float xoff = 0.0;
float yoff = 0.0;

void setup() {
  background(255);
  size(600, 600);
  xoff = width / 2;
  yoff = height / 2;
  noStroke();
  fill(0);
  for (int i = 0; i < 360; i++) {
    float x = map(sin(radians(i)), -1, 1, width / 4, width - width / 4);
    float y = map(cos(radians(i)), -1, 1, height / 4, height - height / 4);
    xoff += 0.02;
    yoff += 0.02;
    float _xoff = noise(map(sin(radians(xoff)), -1, 1, 0, 360)) * 50;
    float _yoff = noise(map(cos(radians(yoff)), -1, 1, 0, 360)) * 50;
    circle(x + _xoff, y + _yoff, 1);
  }
}

void draw() {
}
