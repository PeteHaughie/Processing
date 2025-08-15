PShader myShader;
PImage noise;
PVector m;

void setup() {
    size(800, 600, P2D);
    myShader = loadShader("perception_of_change.frag");
    noise = loadImage("noise.png");
    m = new PVector(0, 0);
    myShader.set("iResolution", (float) width, (float) height);
    myShader.set("iChannel0", noise);
    myShader.set("iTime", millis() / 1000);
    noStroke();
}

void draw() {
    background(255);
    m.x = (float) mouseX;
    m.y = (float) height - mouseY;
    myShader.set("iTime", (float) millis() / 1000);
    myShader.set("iMouse", m);
    shader(myShader);
    rect(0, 0, width, height);
}
