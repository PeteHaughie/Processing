PShader myShader;
PShader myShader2;

void setup() {
    size(720, 512, P2D);
    myShader = loadShader("shader.glsl");
    myShader.set("iResolution", (float) width, (float) height);
    myShader2 = loadShader("shader2.glsl");
}

void draw() {
    shader(myShader);
    myShader.set("iChannel0", get());
    shader(myShader2);
    myShader2.set("iChannel0", get());
    rect(0, 0, width, height);
}

void keyPressed() {
    if (key == char('s')) {
        save("output.png");
    }
}
