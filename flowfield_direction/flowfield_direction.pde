PImage waves;

PGraphics _waves;

int grid = 100; // this will check the image every 4 pixels in a 400 x 400 canvas

boolean showGrid = false;

void setup() {
  size(400, 400);
  waves = loadImage("sines.png");
  _waves = createGraphics(width, height);
  _waves.beginDraw();
  _waves.image(waves, 0, 0);
  _waves.endDraw();
}

void draw() {
  background(255);
  noFill();
  noStroke();
  // show waves
  image(_waves, 0, 0);
  // draw grid
  if (showGrid == true) {
    drawGrid();
  }
}

void drawGrid() {
  stroke(255, 0, 0);
  translate(-(width / grid), -(height / grid));
  for (int x = 0; x <= grid; x++) {
    for (int y = 0; y <= grid; y++) {
      rect((width / grid), (height / grid), (width / grid) * x, (height / grid) * y);
    }
  }
}
