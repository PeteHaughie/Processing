PShader myShader;
PImage texture;

void setup() {
    size(800, 600, P2D);
    myShader = loadShader("loopless_recursion.frag");
    texture = loadImage("victoria.jpeg");
    texture.resize(1112, 1440);
    myShader.set("iResolution", (float) width, (float) height);
    myShader.set("iChannel0", texture);
    noStroke();
}

void draw() {
    myShader.set("iTime", (float) millis() / 1000);
    shader(myShader);
    rect(0, 0, width, height);
}
