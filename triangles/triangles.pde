int scaler = 20;

PGraphics buffer;

void setup() {
  size(420, 420, P3D);
  buffer = createGraphics(400, 400, P3D);
}

void draw() {
  background(0);
  float rot = map(sin(radians(frameCount)), -1, 1, 0, 360);
  buffer.beginDraw();
  buffer.ortho();
  buffer.background(0);
  buffer.stroke(255);
  buffer.strokeWeight(2);
  buffer.translate(200, 0);
  for (int i = 0; i < 5; i++) {
    buffer.rotateY((rot + i) * 0.01);
    buffer.push();
    buffer.translate(-200, 0);
    buffer.line((scaler * i) * 2, (scaler * i) * 2, 200, 400 - ((scaler * i) * 2));
    buffer.line(200, 400 - ((scaler * i) * 2), 400 - ((scaler * i) * 2), (scaler * i) * 2);
    buffer.line(400 - ((scaler * i) * 2), ((scaler * i) * 2), ((scaler * i) * 2), ((scaler * i) * 2));
    buffer.pop();
  }
  buffer.endDraw();
  image(buffer, 10, 10);
  if (frameCount < 720) {
    saveFrame("output/frame-###.png");
  } else {
    exit();
  }
  
}
