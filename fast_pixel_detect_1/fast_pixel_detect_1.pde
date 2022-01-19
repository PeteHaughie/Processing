PGraphics scene;
PGraphics memScene;

PImage image;

int amt = 5;
int cellW;
int cellH;

void setup() {
  size(450, 450, P2D);
  background(255);
  image = loadImage("puppies.jpg");
  noStroke();
  cellW = int(floor(width / amt));
  cellH = int(floor(height / amt));
  
  scene();
}

void scene() {
  scene = createGraphics(width, height);
  scene.beginDraw();
  scene.image(image, (width / 2) - (image.width / 2), (height / 2) - (image.height / 2));
  scene.filter(THRESHOLD);
  scene.endDraw();
}

void memScene() {
  // reduce the scene to the size of the grid
  memScene = createGraphics(width / cellW, height / cellH);

  memScene.beginDraw();
  memScene.background(255);
  memScene.colorMode(GRAY);
  memScene.push();
  memScene.image(scene, 0, 0, width / cellW, height / cellH);
  memScene.pop();
  memScene.endDraw();
}

void examineMemScene() {
  // examine the resized scene by pixel to recreate it full size again
  for (int i = 0; i < memScene.width; i++) {
    for (int j = 0; j < memScene.height; j++) {
      color c = memScene.get(i, j);
      push();
      translate(i * cellW, j * cellH);
      stroke(0);
      strokeWeight(1);
      if (brightness (c) < 255) {
        translate(0, -1);
        strokeWeight(2);
      }
      line(0, 0, cellW, 0);
      //fill(c);
      //rect(i * cellW, j * cellH, cellW, cellH);
      pop();
    }
  }
}

void update() {
  amt = floor(map(sin(radians(frameCount) - 94), -1, 1, 3, image.width / 2));
  cellW = int(floor(width / amt));
  cellH = int(floor(height / amt));
}

void draw() {
  background(255);
  update();
  memScene();
  examineMemScene();
  //saveFrame("./output/frame-####.tif");
}
