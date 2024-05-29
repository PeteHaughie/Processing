PShader colorize, shader1, flipy;
PGraphics buffer, flipybuffer;
PImage victoria;

void setup() {
  size(400, 400, P2D);
  shader1 = loadShader("shader1.frag");
  colorize = loadShader("colorize.frag");
  flipy = loadShader("flipy.frag");
  victoria = loadImage("victoria.jpeg");
  victoria.resize(width, height);
  buffer = createGraphics(width, height, P2D);
  // instantiate the buffer as an image
  buffer.beginDraw();
  buffer.endDraw();
  flipybuffer = createGraphics(width, height, P2D);
}

float mapfloat(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void updateBuffer() {
  shader1.set("u_resolution", (float) width, (float) height);
  shader1.set("u_tex", victoria);
  shader1.set("u_color", mapfloat(sin(radians(frameCount)), -1, 1, 0, 1), mapfloat(sin(radians(frameCount) * 0.9), -1, 1, 0, 1), mapfloat(sin(radians(frameCount) * 0.8), -1, 1, 0, 1));
  shader1.set("u_threshold", mapfloat(sin(radians(frameCount)), -1, 1, 0, 1.5));

  // write the buffer to the buffer
  buffer.beginDraw();
  buffer.clear();
  buffer.shader(shader1);
  buffer.image(buffer, 0, 0);
  buffer.endDraw();

  colorize.set("u_resolution", (float) width, (float) height);
  colorize.set("u_tex0", buffer);
  colorize.set("u_x0", 1.0); // Example value, adjust as needed
  colorize.set("u_x1", 1.0); // Example value, adjust as needed
  colorize.set("u_x2", 1.0); // Example value, adjust as needed
  // colorize.set("u_x0", map(sin(radians(frameCount) * 0.05), -1, 1, 0, 1));
  // colorize.set("u_x1", map(sin(radians(frameCount) * 0.075), -1, 1, 0, 1));
  // colorize.set("u_x2", map(sin(radians(frameCount) * 0.1), -1, 1, 0, 1));

  buffer.beginDraw();
  buffer.clear();
  buffer.shader(colorize);
  buffer.image(buffer, 0, 0);
  buffer.endDraw();

  flipy.set("u_resolution", (float) width, (float) height);
  flipy.set("u_tex0", buffer);

  // flip the y axis
  flipybuffer.beginDraw();
  flipybuffer.shader(flipy);
  flipybuffer.image(buffer, 0, 0);
  flipybuffer.endDraw();
}

void draw() {
  background(255);
  updateBuffer();
  // image(flipybuffer, 0, 0);
  image(buffer, 0, 0);
}
