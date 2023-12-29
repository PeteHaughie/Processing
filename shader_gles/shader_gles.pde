PShader myShader;

void setup() {
    size(300, 300, P2D);
    myShader = loadShader("shader.glsl");
}

void draw() {
    myShader.set("itime", (int) frameCount / 1000);
    shader(myShader);
}
