PShader blurShader;

void setup() {
    size(720, 512, P2D);
    blurShader = loadShader("shader_blur.frag", "shader_blur.vert");
}

void draw() {
    shader(blurShader);
    rect(0, 0, width, height);
}
