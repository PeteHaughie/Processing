import processing.video.*;

Capture cam;

PShader fractal, mixer;

PGraphics fbo0, fbo1;

void setup() {
    size(800, 600, P2D);
    String[] cameras = Capture.list();
    fractal = loadShader("fractals.frag");
    mixer = loadShader("mixer.frag");
    fractal.set("iResolution", (float) width, (float) height);
    fbo0 = createGraphics(width, height, P2D);
    fbo1 = createGraphics(width, height, P2D);
    cam = new Capture(this, 640, 480, "pipeline:autovideosrc");
    cam.start();

    noStroke();
}

void draw() {
    background(0);
    fractal.set("iTime", (float) millis() / 1000);
    if (cam.available() == true) {
        cam.read();
    }

    fbo1.beginDraw();
    fbo1.image(cam, 0, 0);
    fbo1.endDraw();

    fbo0.beginDraw();
    fbo0.shader(mixer);
    fbo0.rect(0, 0, width, height);
    fbo0.endDraw();

    image(fbo0, width, height);
}
