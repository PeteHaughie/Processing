PGraphics scene;

void setup() {
  background(255);
  size(900, 900);
  smooth();
}

void scene() {
  scene = createGraphics(width - 200, height - 200);
  scene.beginDraw();
  scene.background(0);
  scene.stroke(255, 0, 0);
  scene.strokeWeight(3);
  scene.fill(255);
  scene.push();
  scene.translate((width / 2) - 100, (height / 2) - 100);
  scene.rotate(radians(frameCount));
  scene.scale(4);
  scene.ellipse(0, 0, 50, 50);
  scene.ellipse(20, 25, 30, 30);
  scene.ellipse(5, 40, 20, 20);
  scene.noStroke();
  scene.ellipse(0, 0, 50, 50);
  scene.ellipse(20, 25, 30, 30);
  scene.ellipse(5, 40, 20, 20);
  scene.pop();
  scene.endDraw();
}

void draw() {
  image(scene, 100, 100);
  saveFrame("./output/frame-####.tif");
}
