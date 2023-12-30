void setup() {
  size(600, 600);
  float xoff = 0.0; // Start xoff at 0
  float increment = 0.5;
  noStroke();
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff, yoff) * 255;

      fill(bright);
      circle(x, y, 1);
    }
  }

}

void draw() {
}
