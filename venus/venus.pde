PShape venus;

PGraphics buffer;

float y;

void setup() {
  size(400, 400, P3D);
  venus = loadShape("venus.obj");
  venus.disableStyle();
  buffer = createGraphics(width, height, P3D);
}

void updateBuffer(int rotate) {
  buffer.beginDraw();
  buffer.clear();
  buffer.background(0, 100, 255);
  buffer.lights();
  buffer.fill(255, 0, 100);
  buffer.translate(width / 2, height + 75, -200);
  buffer.scale(175);
  buffer.rotateY(radians(180 + y + rotate));
  buffer.rotateX(radians(180));
  buffer.shape(venus);
  buffer.endDraw();
}

void draw() {
  for (int i = 0; i < height; i++) {
    updateBuffer(i / 2);
    image(buffer, 0, i, width, 1, 0, i, width, 1);
  }
  y += 0.5;
  if (frameCount >= 360) {
    exit();
  }
  saveFrame("./output/frame-####.tif");
}
