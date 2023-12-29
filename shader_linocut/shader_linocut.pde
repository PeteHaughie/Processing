import processing.video.*;

Capture cam;

PShader myShader;

void setup() {
    size(720, 512, P2D);
    cam = new Capture(this, width, height);
    cam.start();
    myShader = loadShader("shader.glsl");
    myShader.set("iResolution", (float) width, (float) height);
}

void draw() {
    // Create a new array to store inverted pixels
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
    filter(myShader);
}

void keyPressed() {
    if (key == char('s')) {
        save("output.png");
    }
}
