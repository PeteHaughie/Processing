PShader myShader;
PShader myShader2;
PGraphics pg;
PImage noise;
PImage london;
boolean showSeed = true;

void setup() {
    size(400, 400, P2D);
    pg = createGraphics(400, 400, P2D);
    myShader = loadShader("shader.glsl");
    myShader2 = loadShader("shader2.glsl");
    noise = loadImage("noise.png");
    london = loadImage("london.jpg");
    london.loadPixels();
    int[] newPixels = new int[london.pixels.length];
    for (int y = 0; y < london.height; y++) {
    for (int x = 0; x < london.width; x++) {
        // Calculate the index for the original and the inverted pixel
        int originalIndex = x + y * london.width;
        int invertedIndex = (london.width - 1 - x) + (london.height - 1 - y) * london.width;
        // Set the pixel in the new array
        newPixels[invertedIndex] = london.pixels[originalIndex];
    }
}
    london.pixels = newPixels;
    london.updatePixels();
    myShader.set("iChannel1", noise);
    myShader.set("iChannel2", london);
    myShader.set("iResolution", (float)width, (float)height);
    noStroke();
}

void draw() {
    myShader.set("iFrame", frameCount);
    myShader.set("iChannel0", get());   
    myShader2.set("iChannel0", get());
    pg.beginDraw();
    pg.shader(myShader);
    pg.rect(0, 0, width, height);
    pg.endDraw();
    image(pg, 0, 0);
    shader(myShader2);
    // if (frameCount % 2 == 0) {
    //     shader(myShader);
    // } else {
    //     shader(myShader2);
    // }
    rect(0, 0, width, height);
}

void keyPressed() {
    if (key == char('s')) {
        save("output.png");
    }
}
