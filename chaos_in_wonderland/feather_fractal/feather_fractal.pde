float aa = -0.48,
      b = 0.93,
      c = 2.0-2.0*aa,
      x = -10.0,
      y = 10.0,
      w = aa*x + c*(x*x)/(1.0 + x*x);

void setup() {
  background(255);
  size(900, 900);
  stroke(0);
  strokeWeight(2);
}

void draw() {
  translate(width / 2 - 50, height / 2);
  for (int i = 0; i < 1000; i++) {
    point(x * 30, y * 30);
    float z = x;
    x = b*y + w;
    float u = x*x;
    w = aa*x + c*u/(1.0 + u);
    y = w - z;
  }
  if (frameCount > 100) {
    exit();
  } else {
    saveFrame("./output/frame-####.tif");
  }
}
