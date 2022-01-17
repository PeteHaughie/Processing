void setup() {
  size(900, 900, P2D);
  stroke(0);
  strokeWeight(10);
  strokeCap(ROUND);
}

float xoff = 0.0;
float yoff = 0.0;

void draw() {
  background(255);
  translate(100, 100);
  for (int i = 0; i < (int)(width - 200) / 15; i++) {
    for (int j = 0; j < (int)(height - 200) / 15; j++) {
      float wxoff = map(sin(radians(xoff * 250)), 0.0, 0.25, 0.01, 0.1);
      float wyoff = map(sin(radians(yoff * 250)), 0.0, 0.50, 0.02, 0.2);
      float n1 = map(noise(wxoff + (i * 0.15) * 0.1, wyoff + (j * 0.1) * 0.15), 0, 1, -75, 75);
      float n2 = map(noise(wxoff + (i * 0.25) * 0.2, wyoff + (j * 0.2) * 0.25), 0, 1, -50, 50);
      push();
      translate(i * 15, j * 15);
      stroke((int)map(dist(0.0, 0.0, n1, n2), 0, 70, 0, 225));
      line(0, 0, n1, n2);
      pop();
    }
  }
  xoff += 0.003;
  yoff += 0.005;
  if (frameCount < 1000) {
    saveFrame("./output/frame-####.tif");
  } else {
    exit();
  }
}
