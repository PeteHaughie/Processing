import processing.video.*;
PImage noise;
Capture cam;
boolean doInit = true;
PShader myShader;

void setup() {
    size(720, 512, P2D);
    cam = new Capture(this, width, height);
    cam.start();
    myShader = loadShader("shader.glsl");
    noise = loadImage("noise.png");
    myShader.set("iChannel1", noise);
    for (int i = 0; i < 2; i++) {
        myShader.set("iChannelResolution[" + i + "]", float(width), float(height));
    }
}

void draw() {
    if (cam.available()) {
        cam.read();
        myShader.set("iChannel2", cam);
    }
    if (doInit) {
        myShader.set("doInit", false);
        doInit = false;
    }
    filter(myShader);
}
