import processing.video.*;

Capture cam;

PImage david;

PGraphics pattern;
PGraphics buffer1;
PGraphics _buffer1;
PGraphics buffer2;
PGraphics _buffer2;
PGraphics buffer3;
PGraphics _buffer3;

void setup() {
    size(720, 512);
    // cam = new Capture(this, width, height);
    // cam.start();
    david    = loadImage("david.jpg");
    pattern  = createGraphics(width * 3, height * 5);
    buffer1  = createGraphics(width, height);
    _buffer1 = createGraphics(width, height);
    buffer2  = createGraphics(width, height);
    _buffer2 = createGraphics(width, height);
    buffer3  = createGraphics(width, height);
    _buffer3 = createGraphics(width, height);
}

// TODO:
// Set threshold values of same image at three different limits - done
// this will be our low, mid, and high values
// write each of those values to the main canvas as r, g, and b for testing - done
// replace colour output with masks of another banded image at different rotations and scales - done in two differrent ways
// then try it with camera

void updatePattern(int weight, int spacing) {
    pattern.beginDraw();
    pattern.background(255);
    int gridSize = 10;
    pattern.fill(0);
    for (int i = 0; i < pattern.height / gridSize; i++) {
        pattern.rect(0, (gridSize * spacing) * i, pattern.width, weight);
    }
    pattern.endDraw();
}

void updateBuffer1() {
    buffer1.beginDraw();
    buffer1.background(0);
    buffer1.image(david, 0, 0, width, height);
    // buffer1.image(cam, 0, 0, width, height);
    buffer1.filter(THRESHOLD, 0.25);
    buffer1.endDraw();
}

void _updateBuffer1() {
    updatePattern(4, 2);
    _buffer1.beginDraw();
    _buffer1.pushMatrix();
    _buffer1.scale(.5);
    _buffer1.rotate(radians(90));
    _buffer1.translate(-100, -1000);
    _buffer1.image(pattern, -width, -height, pattern.width, pattern.height);
    _buffer1.popMatrix();
    _buffer1.mask(buffer1);
    _buffer1.endDraw();
}

void updateBuffer2() {
    buffer2.beginDraw();
    buffer2.image(david, 0, 0, width, height);
    // buffer2.image(cam, 0, 0, width, height);
    buffer2.filter(THRESHOLD, 0.5);
    buffer2.endDraw();
}

void _updateBuffer2() {
    updatePattern(3, 2);
    _buffer2.beginDraw();
    _buffer2.pushMatrix();
    _buffer2.scale(.5);
    _buffer2.rotate(radians(-30));
    _buffer2.translate(-100, -300);
    _buffer2.image(pattern, -width, -height, pattern.width, pattern.height);
    _buffer2.popMatrix();
    _buffer2.mask(buffer2);
    _buffer2.endDraw();
}

void updateBuffer3() {
    buffer3.beginDraw();
    buffer3.image(david, 0, 0, width, height);
    // buffer3.image(cam, 0, 0, width, height);
    buffer3.filter(THRESHOLD, 0.75);
    buffer3.endDraw();
}

void _updateBuffer3() {
    updatePattern(2, 2);
    _buffer3.beginDraw();
    _buffer3.pushMatrix();
    _buffer3.scale(.5);
    _buffer3.rotate(radians(90));
    _buffer3.translate(-100, -500);
    _buffer3.image(pattern, -width, -height, pattern.width, pattern.height);
    _buffer3.popMatrix();
    _buffer3.mask(buffer3);
    _buffer3.endDraw();
}

void draw() {
    background(20, 50, 120);
    noStroke();

    // image(david, 0, 0, width, height);
    /*
    if (cam.available()) {
        cam.read();
    }
    */
    // image(cam, 0, 0, width, height);
    // filter(GRAY);

    updateBuffer1();
    _updateBuffer1();
    updateBuffer2();
    _updateBuffer2();
    updateBuffer3();
    _updateBuffer3();

    // run the transformations on the buffers
    /*
    buffer1.loadPixels();
    for (int y = 0; y < buffer1.height; y++) {
        for (int x = 0; x < buffer1.width; x++) {
            color c = buffer1.get(x, y);
            if (brightness(c) > 0) {
                fill(0);
                rect(x, y, 1, 1);
            }
        }
    }
    buffer2.loadPixels();
    for (int y = 0; y < buffer2.height; y++) {
        for (int x = 0; x < buffer2.width; x++) {
            color c = buffer2.get(x, y);
            if (brightness(c) > 0) {
                fill(125);
                rect(x, y, 1, 1);
            }
        }
    }
    buffer3.loadPixels();
    for (int y = 0; y < buffer3.height; y++) {
        for (int x = 0; x < buffer3.width; x++) {
            color c = buffer3.get(x, y);
            if (brightness(c) > 0) {
                fill(255);
                rect(x, y, 1, 1);
            }
        }
    }
    */

    // try running the same transformations on the buffers buffers
    /*
    _buffer1.loadPixels();
    for (int y = 0; y < _buffer1.height; y++) {
        for (int x = 0; x < _buffer1.width; x++) {
            color c = _buffer1.get(x, y);
            if (brightness(c) > 0) {
                fill(0);
                rect(x, y, 1, 1);
            }
        }
    }
    _buffer2.loadPixels();
    for (int y = 0; y < _buffer2.height; y++) {
        for (int x = 0; x < _buffer2.width; x++) {
            color c = _buffer2.get(x, y);
            if (brightness(c) > 0) {
                fill(125);
                rect(x, y, 1, 1);
            }
        }
    }
    _buffer3.loadPixels();
    for (int y = 0; y < _buffer3.height; y++) {
        for (int x = 0; x < _buffer3.width; x++) {
            color c = _buffer3.get(x, y);
            if (brightness(c) > 0) {
                fill(255);
                rect(x, y, 1, 1);
            }
        }
    }
    */

    // image(pattern, -width, -height, pattern.width, pattern.height);
    // image(buffer1, 0, 0, width, height);
    image(_buffer1, 0, 0, width, height);
    // image(buffer2, 0, 0, width, height);
    image(_buffer2, 0, 0, width, height);
    // image(buffer3, 0, 0, width, height);
    image(_buffer3, 0, 0, width, height);
    // image(david, 0, 0, width, height);
}

void keyPressed() {
    if (key == char('s')) {
        save("output.png");
    }
}