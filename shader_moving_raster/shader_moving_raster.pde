import processing.video.*;

Capture cam;

PShader myShader;

void setup() {
    size(720, 512, P2D);
    myShader = loadShader("shader.glsl");
    cam = new Capture(this, width, height);
    cam.start();
    myShader.set("iResolution", (float) width, (float) height);
    myShader.set("iChannelResolution", (float) width, (float) height);
}

void draw() {
    if (cam.available()) {
        cam.read();
        cam.loadPixels();
        int[] newPixels = new int[cam.pixels.length];
        for (int y = 0; y < cam.height; y++) {
            for (int x = 0; x < cam.width; x++) {
                int originalIndex = x + y * cam.width;
                int invertedIndex = (cam.width - 1 - x) + (cam.height - 1 - y) * cam.width;
                newPixels[invertedIndex] = cam.pixels[originalIndex];
            }
        }
        cam.pixels = newPixels;
        cam.updatePixels();
        myShader.set("iChannel0", cam);
    }
    myShader.set("iTime", (float) frameCount / 100);
    filter(myShader);
}

void keyPressed() {
    if (key == char('s')) {
        save("output.png");
    }
}
