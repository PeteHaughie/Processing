import processing.video.*;

PGraphics buffer;
PGraphics camBuffer;
PShader myShader;

Capture cam;

int bufferArrayLength = 4;

//the buffer for storing video frames
ArrayList frames = new ArrayList();

void setup() {
  //background(255, 0, 0);
  size(1080, 720, P2D);
  println(frameRate);
  noStroke();
  cam       = new Capture(this, width, height);
  buffer    = createGraphics(width, height, P2D);
  camBuffer = createGraphics(width, height, P2D);
  myShader  = loadShader("shader.glsl");
  myShader.set("uResolution", (float) width, (float) height);
  cam.start();
  updateBuffer();
}

void updateBuffer() {
  buffer.beginDraw();
  buffer.image(cam, 0, 0, width, height);
  int currentImage = 0;
  if (currentImage < frames.size()) {
    PImage img = (PImage)frames.get(currentImage);
    buffer.blend(img, 0, 0, width, height, 0, 0, width, height, DIFFERENCE);
  }
  buffer.endDraw();
  camBuffer.beginDraw();
  camBuffer.image(cam, 0, 0, width, height);
  camBuffer.endDraw();
}

void captureEvent(Capture camera) {
  camera.read();
  
  // Copy the current video frame into an image, so it can be stored in the buffer
  PImage img = createImage(width, height, RGB);
  cam.loadPixels();
  arrayCopy(cam.pixels, img.pixels);
  
  frames.add(img);
  
  // Once there are enough frames, remove the oldest one when adding a new one
  if (frames.size() > bufferArrayLength) {
    frames.remove(0);
  }
}

void draw() {
  //image(cam, 0, 0, width, height);
  updateBuffer();
  myShader.set("uBuffer", buffer);
  myShader.set("uOrigin", camBuffer); // this needs to be mirrored vertically for some reason
  // image(buffer, 0, 0, width, height);
  // image(camBuffer, 0, 0, width, height);
  shader(myShader);
  rect(0, 0, width, height);
}

void keyPressed() {
  if (key == 's') {
    saveFrame("output/####.png");
  }
}
