PShader myShader;

void setup() {
    size(800, 600, P2D);
    myShader = loadShader("perlinfall.frag");
    myShader.set("iResolution", (float) width, (float) height);
    myShader.set("iTime", millis() / 1000);
    noStroke();
    fill(255, 0, 0);
}

void draw() {
    myShader.set("iTime", (float) millis() / 1000);
    filter(myShader);
    // rect(0, 0, width, height);
}