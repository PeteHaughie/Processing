import controlP5.*;

ControlP5 cp5;

PShape mesh;
PImage victoria;
int gridHeight;

int gridSize;
Slider abc;

void setup() {
  size(640, 480, P3D);
  mesh = createShape();
  noStroke();
  victoria = loadImage("victoria.jpeg");
  victoria.resize(640, 480);
  gridSize = (int)height / 10;
  gridHeight = gridSize;
  cp5 = new ControlP5(this);
  cp5.addSlider("grid size")
     .setPosition(20, 10)
     .setRange(0, height)
     .setNumberOfTickMarks(gridHeight)
     ;
}

void draw() {
  background(255);
  textureMode(NORMAL);
  beginShape(QUAD_STRIP);
  texture(victoria);
  float textureStepV = 1.0 / (victoria.height - 1);
  for (int i = 0; i < gridSize; i++) {
    float textureV = i * textureStepV;
    vertex(0, i, 0, textureV);
    vertex(width, i, 1, textureV);
  }
  endShape(CLOSE);
}
