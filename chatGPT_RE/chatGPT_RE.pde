import processing.video.*;

Capture cam;
int scanlineSpacing = 10;
int lineHeight = 480;
int thresholdValue = 10;
PImage lastFrame;

void setup() {
  size(640, 480);
  cam = new Capture(this, width, height);
  cam.start();
  lastFrame = createImage(width, height, RGB);
}

void draw() {
  if (cam.available()) {
    cam.read();
    image(cam, 0, 0, width, height);
    drawScanlines();
    lastFrame.copy(cam, 0, 0, width, height, 0, 0, width, height);
  }
}

void drawScanlines() {
  loadPixels();
  lastFrame.loadPixels();
  
  for (int y = 1; y < height; y += scanlineSpacing) {
    for (int x = 0; x < width; x++) {
      int index = y * width + x;
      
      color currentColor = pixels[index];
      color previousColor = pixels[index - width];
      
      float currentBrightness = brightness(currentColor);
      float previousBrightness = brightness(previousColor);
      
      if (abs(currentBrightness - previousBrightness) > thresholdValue) {
        for (int i = 0; i < lineHeight; i++) {
          if (y + i < height) {
            pixels[index + i * width] = currentColor;
          }
        }
      }
    }
  }
  
  updatePixels();
}
