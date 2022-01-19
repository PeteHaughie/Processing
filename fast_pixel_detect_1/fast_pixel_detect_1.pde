PGraphics scene;
PGraphics memScene;

PImage image;

int amt = 90;
int cellW;
int cellH;


void setup() {
  size(900, 900);
  background(255);
  noStroke();
  image = loadImage("puppies.jpg");

  cellW = int(floor(width / amt));
  cellH = int(floor(height / amt));

  scene = createGraphics(width, height);
  scene.beginDraw();
  scene.image(image, (width / 2) - (image.width / 2), (height / 2) - (image.height / 2));
  scene.endDraw();

  // reduce the scene to the size of the grid
  memScene = createGraphics(width / cellW, height / cellH);
  memScene.beginDraw();
  memScene.push();
  memScene.image(scene, 0, 0, width / cellW, height / cellH);
  memScene.pop();
  memScene.endDraw();

  // examine the resized scene by pixel to recreate it full size again
  for (int i = 0; i < width / cellW; i++) {
    for (int j = 0; j < height / cellH; j++) {
      color c = memScene.get(i, j);
      push();
      stroke(0);
      strokeWeight(2);
      translate(i * cellW, j * cellH);
      translate(0, cellH / 2 + 2);
      line(0, 0, cellW, 0);
      if (brightness (c) < 255) {
        stroke(255, 0, 0);
      }
      pop();
    }
  }

  //drawGrid();
}

void draw() {
  //image(memScene, 0, 0);
  //image(scene, 0, 0, width, height);
  
}

void drawGrid() {
  for (int i = 0; i < width / cellW; i++) {
    for (int j = 0; j < height / cellH; j++) {
      //fill(random(255));
      rect(i * cellW, j * cellH, cellW, cellH);
    }
  }
}
