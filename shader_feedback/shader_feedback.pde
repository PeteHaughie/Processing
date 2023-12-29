PShader myShader;
PGraphics bof;
boolean invert = false;

void setup() {
    background(255);
    size(400, 400, P2D);
    noStroke();
    myShader = loadShader("shader.frag");
    myShader.set("u_resolution", (float)width, (float)height);
    bof = createGraphics(width, height, P2D);
}

void updateBuffer() {
    bof.beginDraw();
    bof.filter(myShader);
    bof.circle(map(sin(radians(frameCount) * (random(1, 3) * 0.1)), -1, 1, 0, width), map(sin(radians(frameCount * (random(1, 2) * 0.1))), -1, 1, 0, height), 10);
    bof.endDraw();
}

void draw() {
    updateBuffer();
    PImage snap = bof.get();
    myShader.set("u_texture", snap);
    tint(255, 10);
    if (invert) {
        invert = !invert;
        filter(INVERT);
    }
    filter(BLUR, 4);
    image(snap, 0, 0, width, height);
}

void keyPressed() {
    if (key == 'v') {
        bof.fill(random(0, 255), random(0, 255), random(0, 255));
    }
    if (key == 'c') {
        bof.fill(255);
    }
    if (key == 'i') {
        invert = !invert;
    }
}