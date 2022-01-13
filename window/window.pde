PImage sky;
PShape dome;

PGraphics scene, texture;

int DOMESIZE = 10000;

float mx, my;

void setup() {
  size(900, 900, P3D);
  sky = loadImage("sky.jpg");
  dome = createShape(SPHERE, DOMESIZE);
  dome.textureMode(NORMAL);
  dome.setTexture(sky);
  dome.setStroke(false);
  
  scene = createGraphics(width, height, P3D);
  texture = createGraphics(width, height, P3D);
  
  imageMode(CENTER);
  
}

void draw() { 
  drawScene();
  image(scene, width / 2, height / 2);
}

void drawScene() {
  scene.beginDraw();

  scene.camera(
    width / 2.0,
    height / 2.0 + my,
   (height / 2.0) / tan(PI*30.0 / 180.0),
    width / 2.0,
    height / 2.0,
    0,
    0,
    1,
    0
  );
  scene.perspective(PI/3.0, (float)width/height, 1, DOMESIZE);
  
  // skybox
  scene.fill(#0000FF);
  scene.noStroke();
  scene.push();
  scene.translate(scene.width / 2, scene.height / 2);
  scene.rotateY(radians(frameCount * 0.01));
  scene.texture(sky);
  scene.shape(dome);
  scene.pop();

  
  scene.endDraw();
}

void update() {
  mx = mouseX;
  my = mouseY;
}
