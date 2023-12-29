PImage noise;
PShader myShader;
PGraphics bof;

void setup() {
    // size(640, 480, P2D);
    fullScreen(P2D);
    noise = loadImage("noise.png");
    myShader = loadShader("shader.glsl");
    myShader.set("iResolution", (float) width / 2, (float) height / 2);
    myShader.set("iChannel0", noise);
    myShader.set("iChannelResolution", (float) noise.width, (float) noise.height);
    bof = createGraphics(width / 2, height / 2, P2D); // we don't need fullscreen
}

void updateBOF() {
    bof.beginDraw();
    bof.filter(myShader);
    bof.endDraw();
}

void draw() {
    myShader.set("iMouse", (float) (mouseX / 2), (float) (mouseY / 2));
    myShader.set("iTime", millis() / 1000.0);
    updateBOF();
    image(bof, 0, 0, width, height);
}