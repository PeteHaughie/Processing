PShader myShader;

void setup() {
    size(1080, 720, P2D);
    // fullScreen(P2D);
    myShader = loadShader("shader.glsl");
    myShader.set("iResolution", (float) width, (float) height);
}

void draw() {
    myShader.set("iMouse", (float) mouseX, (float) mouseY);
    myShader.set("iTime", millis() / 1000.0);
    filter(myShader);
}