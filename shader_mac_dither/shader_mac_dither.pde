import processing.video.*;

Capture cam;

PShader myShader;
PImage london;
void setup() {
    size(720, 512, P2D);
    // cam = new Capture(this, 720, 512);
    // cam.start();
    myShader = loadShader("shader.glsl");
    london = loadImage("london.jpg");
    myShader.set("iResolution", (float) width, (float) height);
}

void draw() {
    // if (cam.available()) {
    //     cam.read();
    //     myShader.set("iChannel0", cam);
    // }
    // myShader.set("u_time", millis() / 1000.0);
    myShader.set("iChannel0", london);
    filter(myShader);
}

void keyPressed() {
    if (key == char('s')) {
        save("output.png");
    }
}