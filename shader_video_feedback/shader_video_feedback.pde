import processing.video.*;

Capture cam;

PShader myShader;
PGraphics bof;
boolean invert = false;

void setup() {
    background(255);
    size(640, 480, P2D);
    noStroke();
    cam = new Capture(this, width, height);
    cam.start();
    myShader = loadShader("shader.frag");
    myShader.set("u_resolution", (float)width, (float)height);
    bof = createGraphics(width, height, P2D);
}

void updateBuffer() {
    bof.beginDraw();
    bof.filter(myShader);
    bof.endDraw();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
    updateBuffer();
    PImage snap = bof.get();
    myShader.set("u_texture", cam);
    tint(255, 10);
    image(snap, 0, 0, width, height);
}

void keyPressed() {
    if (key == 'i') {
        invert = !invert;
    }
}