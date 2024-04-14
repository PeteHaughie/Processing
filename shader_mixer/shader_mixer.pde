PImage img1, img2, img3, img4;
PGraphics buffer1, buffer2, buffer3, buffer4;
float opacityx, opacityy;
PShader shader;

static float mapf(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void setup() {
  size(720, 480, P2D); // Set the size of the window
  // Load images
  img1 = loadImage("image1.jpeg");
  img2 = loadImage("image2.jpeg");
  img3 = loadImage("image3.jpeg");
  img4 = loadImage("image4.jpeg");

  buffer1 = createGraphics(width, height);

  buffer1.beginDraw();
  buffer1.image(img1, 0, 0);
  buffer1.endDraw();

  buffer2 = createGraphics(width, height);

  buffer2.beginDraw();
  buffer2.image(img2, 0, 0);
  buffer2.endDraw();

  buffer3 = createGraphics(width, height);

  buffer3.beginDraw();
  buffer3.image(img3, 0, 0);
  buffer3.endDraw();

  buffer4 = createGraphics(width, height);

  buffer4.beginDraw();
  buffer4.image(img4, 0, 0);
  buffer4.endDraw();

  // Load the shader and set the texture uniforms
  shader = loadShader("mixer.glsl");
  shader.set("resolution", (float) width, (float) height);
  shader.set("tex0", buffer1);
  shader.set("tex1", buffer2);
  shader.set("tex2", buffer3);
  shader.set("tex3", buffer4);
}

void draw() {
  background(0);
  float mvalx = mapf(mouseX, 0, width, 0, 1);
  float mvaly = mapf(mouseY, 0, height, 0, 1);
  shader.set("opacityx", mvalx);
  shader.set("opacityy", mvaly);
  filter(shader);
}
