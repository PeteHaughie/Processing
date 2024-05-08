import processing.video.*;
PShader myShader;

PGraphics buffer1;
PGraphics buffer2;

Movie movie1;
Movie movie2;

float fadeAmt;

void setup() {
  //size(640, 420, P2D);
  fullScreen(P2D);
  myShader = loadShader("shader.frag.glsl");
  myShader.set("iResolution", (float) width, (float) height);
  movie1 = new Movie(this, "Coven.2000.x264.8bit.DVD 120.00.m4v Render 21 120.00.mp4");
  movie1.loop();
  buffer1 = createGraphics(width, height, P2D);
  movie2 = new Movie(this, "Coven.2000.x264.8bit.DVD 120.00.m4v Render 20 120.00.mp4");
  movie2.loop();
  buffer2 = createGraphics(width, height, P2D);
}

void movieEvent(Movie m) {
  m.read();
}

void updateBuffer1() {
  buffer1.beginDraw();
  buffer1.image(movie1, 0, 0, width, height);
  buffer1.endDraw();
}

void updateBuffer2() {
  buffer2.beginDraw();
  buffer2.image(movie2, 0, 0, width, height);
  buffer2.endDraw();
}

void draw() {
  background(0);
  fadeAmt = map(sin(radians(frameCount)), -1, 1, 0, 1);
  updateBuffer1();
  updateBuffer2();
  myShader.set("tex1", buffer1);
  myShader.set("tex2", buffer2);
  myShader.set("opacity", fadeAmt);
  filter(myShader);
}
