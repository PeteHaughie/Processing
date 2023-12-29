import processing.video.*;

Capture cam;

PShader myShader;
PImage dither_tex;

void setup(){
    size(400, 400, P2D);
    dither_tex = loadImage("dither.png");
    myShader = loadShader("shader.glsl");
    myShader.set("iChannel0", dither_tex);
    myShader.set("iResolution", (float) width, (float) height);
    myShader.set("iChannelResolution", (float) width, (float) height);
}

void draw(){
    filter(myShader);
    myShader.set("iMouse", (float) mouseX, (float) mouseY);
    myShader.set("iTime", millis() / 1000.0);
}