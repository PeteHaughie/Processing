PImage galaxy,
       sky,
       floor;

PImage g;

PGraphics otherScene,
          otherTexture;

PGraphics scene,
          texture;

PShape dome,
       otherDome;

int BG = 0;
int DOMESIZE = 100000;
float cameraZ = -5000;
float MAGNITUDE = 100000;
float speed = 50;

float mx,
      my;

float eyeX,
      eyeY,
      eyeZ;

float centerX,
      centerY,
      centerZ;

float upX,
      upY,
      upZ;

void setup() {
  size(900, 450, P3D);
  textureWrap(REPEAT);
  
  // other dome
  galaxy = loadImage("galaxy.jpg");
  otherDome = createShape(SPHERE, DOMESIZE);
  otherDome.textureMode(NORMAL);
  otherDome.setTexture(galaxy);
  otherDome.setStroke(false);

  // dome
  sky = loadImage("sky.jpg");
  dome = createShape(SPHERE, DOMESIZE);
  dome.textureMode(NORMAL);
  dome.setTexture(sky);
  dome.setStroke(false);

  // floor
  floor = loadImage("floor2.jpg");
  
  scene = createGraphics(width, height, P3D);
  texture = createGraphics(width, height, P3D);

  otherScene = createGraphics(width, height, P3D);
  otherTexture = createGraphics(width, height, P3D);
  
  imageMode(CENTER);
  
}

void draw() {
  update();
  interactionKeyboard();
  drawScene();
  drawOtherScene();
  portal();
  image(scene, width / 2, height / 2);
}
