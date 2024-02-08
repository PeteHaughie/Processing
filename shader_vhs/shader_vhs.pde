PShader myShader;
PImage london;
PImage texture;
PGraphics buffer;

void setup() {
    frameRate(12);
    size(1280, 720, P2D);
    //fullScreen(P2D);
    buffer = createGraphics(width, height, P2D);
    myShader = loadShader("shader.glsl");
    myShader.set("iResolution", (float) width, (float) height);
    london = loadImage("london.jpg");
    texture = loadImage("texture.jpg");
    myShader.set("iChannel0", texture);
    myShader.set("iChannel1", london);
    noStroke();
}

void updateBuffer() {
    myShader.set("iTime", millis() / 10);
    buffer.beginDraw();
    buffer.shader(myShader);
    buffer.rect(0, 0, width, height);
    buffer.endDraw();
}

void draw() {
    background(0);
    // update the buffer
    updateBuffer();
    // flip the canvas
    scale(1, -1);
    translate(0, -height);
    // draw the buffer to the screen
    image(buffer, 0, 0, width, height);
}
