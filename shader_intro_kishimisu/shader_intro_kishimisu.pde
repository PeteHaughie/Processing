PShader myShader;

void setup() {
    // size(400, 400, P2D);
    fullScreen(P2D);
    myShader = loadShader("shader.glsl");
    myShader.set("u_resolution", (float) width, (float) height);
}

void draw() {
    filter(myShader);
    myShader.set("u_time", millis() / 1000.0);
}
