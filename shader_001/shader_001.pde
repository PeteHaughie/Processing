PShader myShader;

void setup() {
    size(512, 512, P2D);
    myShader = loadShader("translate.frag");
    myShader.set("u_resolution", float(width), float(height));
}

void draw() {
    background(0);
    shader(myShader);
    rect(0, 0, width, height);
}
