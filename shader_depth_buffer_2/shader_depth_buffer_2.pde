import peasy.*;

final int size = 500;

PShader shader;

PGraphics canvas;
PGraphics depthImage;

PeasyCam cam;

float near = 0f;
float far = 1000f;

boolean shaderApplied = false;

void settings() {
  size(size * 2, size, P3D);
  PJOGL.profile = 4;
  pixelDensity(displayDensity());
}

void setup() {
  shader = loadShader("depthFrag.glsl", "depthVert.glsl");
  shader.set("near", near);
  shader.set("far", far);

  // setup other objects
  canvas = createGraphics(size, size, P3D);
  depthImage = createGraphics(size, size, P2D);

  cam = new PeasyCam(this, 1000);
} 
void draw() {
  background(0);

  // render 3d
  render(canvas);
  cam.getState().apply(canvas);

  createDepthImage((PGraphics3D)canvas);

  // show output onto onscreen canvas
  cam.beginHUD();
  image(canvas, 0, 0);
  image(depthImage, size, 0);

  textSize(15);
  text("ORIGINAL (3D)", 25, 25);
  text("DEPTH (2D)", size + 25, 25);
  text("FPS: " + frameRate, 25, height - 25);
  cam.endHUD();
}

void createDepthImage(PGraphics3D graphics)
{
  if (!graphics.is3D())
    return;

  // add shader to graphics
  graphics.shader(shader);

  depthImage.beginDraw();
  depthImage.image(graphics, 0, 0);
  depthImage.endDraw();

  // reset shader after operation
  if (!shaderApplied)
    graphics.resetShader();
}

void render(PGraphics graphics)
{
  float size = 4.0f;

  graphics.beginDraw();
  graphics.background(55);

  graphics.pushMatrix();

  //canvas.translate(canvas.width / 2, canvas.height / 2);
  graphics.rotateX(radians(frameCount % 360));
  graphics.rotateZ(radians(frameCount % 360));

  graphics.noStroke();
  graphics.fill(20, 20, 20);
  graphics.box(100 * size);

  graphics.fill(150, 255, 255);
  graphics.sphere(60 * size);

  graphics.popMatrix();
  graphics.endDraw();
  graphics.endDraw();
}

void keyPressed()
{
  if (shaderApplied)
    canvas.resetShader();
  else
    canvas.shader(shader);

  shaderApplied = !shaderApplied;
}