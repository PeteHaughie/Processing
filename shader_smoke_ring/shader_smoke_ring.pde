PShader myShader;

void setup() {
    size(800, 600, P2D);
    myShader = loadShader("smoke_ring.frag");
    myShader.set("iResolution", (float) width, (float) height);
    noStroke();
}

void draw() {
    myShader.set("iTime", (float) millis() / 1000);
    filter(myShader);
    rect(0, 0, width, height);
}
