PGraphics buffer;
float pixelSize = 5; // Diameter of the circles
int waveScale = 5;
PImage pic;

void setup() {
  size(800, 600);
  buffer = createGraphics(width, height);

  // Draw something on the buffer (e.g., a black rectangle)
  buffer.beginDraw();
  buffer.background(255); // Set background to white
  buffer.fill(0); // Set fill color to black
  pic = loadImage("01_simpleColorQuadExample.png");
  buffer.rect(50, 50, buffer.width - 100, buffer.height - 100); // Draw the rectangle
  buffer.endDraw();
}

void applyWavyEffect() {
  buffer.loadPixels();

  // Temporary array to hold the new pixel data
  int[] tempPixels = new int[buffer.pixels.length];
  for (int i = 0; i < tempPixels.length; i++) {
    tempPixels[i] = color(255); // Fill with white
  }

  // Apply the wavy effect by manipulating pixel positions
  for (int y = 0; y < buffer.height; y++) {
    for (int x = 0; x < buffer.width; x++) {
      int newX = x + int(sin(y * 0.05) * waveScale); // Horizontal wave effect
      int newY = y + int(sin(x * 0.05) * waveScale); // Vertical wave effect
      
      if (newX >= 0 && newX < buffer.width && newY >= 0 && newY < buffer.height) {
        int origIndex = x + y * buffer.width;
        int newIndex = newX + newY * buffer.width;
        tempPixels[newIndex] = buffer.pixels[origIndex];
      }
    }
  }

  // Copy the manipulated pixels back to the buffer
  buffer.pixels = tempPixels;
  buffer.updatePixels();
}

void draw() {
  background(255);
  
  applyWavyEffect(); // Apply the wavy effect

  // Instead of using image(), draw circles for each pixel
  for (int y = 0; y < buffer.height; y++) {
    for (int x = 0; x < buffer.width; x++) {
      int index = x + y * buffer.width;
      int col = buffer.pixels[index];
      fill(col);
      noStroke();
      rect(x, y, pixelSize, pixelSize); // Draw circles at each pixel's position
    }
  }
  noLoop(); // Static image, no need to loop
}
