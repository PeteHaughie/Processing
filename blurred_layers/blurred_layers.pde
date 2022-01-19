PGraphics scene1;
PGraphics scene2;
PGraphics scene3;
PGraphics composite;

void setup() {
  size(900, 900, P2D);
}

float wave1;
float wave2;
float wave3;

void update() {
  scene1 = createGraphics(width - 200, height - 200);
  wave1 = map(sin(radians(frameCount * 0.5)), -1, 1, 100, scene1.width - 100);
  scene1.beginDraw();
  scene1.noStroke();
  scene1.push();
  scene1.fill(255, 0, 0);
  scene1.ellipse(wave1, scene1.height / 2, 30, 30);
  scene1.pop();
  scene1.filter(BLUR, 6);
  scene1.endDraw();
  
  scene2 = createGraphics(width - 200, height - 200);
  wave2 = map(sin(radians(frameCount * 0.7)), -1, 1, 100, scene1.width - 100);
  scene2.beginDraw();
  scene2.noStroke();
  scene2.push();
  scene2.fill(0, 0, 255);
  scene2.image(scene1, 0, 0);
  scene2.ellipse(wave2, scene2.height / 2, 60, 60);
  scene2.pop();
  scene2.filter(BLUR, 6);
  scene2.endDraw();

  scene3 = createGraphics(width - 200, height - 200);
  wave3 = map(sin(radians(frameCount * 0.9)), -1, 1, 100, scene1.width - 100);
  scene3.beginDraw();
  scene3.noStroke();
  scene3.background(0);
  scene3.push();
  scene3.fill(255);
  scene3.image(scene2, 0, 0);
  scene3.ellipse(wave3, scene3.height / 2, 120, 120);
  scene3.pop();
  scene3.endDraw();

  }

void draw() {
  background(255);
  update();
  image(scene3, 100, 100);
}
