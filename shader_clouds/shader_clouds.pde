PShader myShader;

PGraphics buffer;

int w = 320;
int h = 240;

void setup() {
    //size(320, 240, P2D);
    fullScreen(P2D);
    myShader = loadShader("shader.glsl");
    myShader.set("iResolution", (float) w, (float) h);
    buffer = createGraphics(w, h, P2D);
}

void updateBuffer() {
  buffer.beginDraw();
  buffer.filter(myShader);
  buffer.endDraw();
}

float returnSine(float val, float max) {
  float r = map(sin(radians(val)), -1, 1, 0, max);
  return r;
}

void draw() {
  frameRate(30);
  updateBuffer();
  myShader.set("iMouse", returnSine(frameCount * 0.1, w), returnSine(frameCount * 0.05, h));
  myShader.set("iTime", (float) millis() / 1000);
  image(buffer, 0, 0, width, height);
}
