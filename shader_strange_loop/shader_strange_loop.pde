PShader hueShift, lumaKey, shader1, shader2, shader3, shader4;
PGraphics buffer1, buffer2, buffer3, buffer4, buffer5, buffer6;
PImage victoria;

void setup() {
  size(400, 400, P2D);
  victoria = loadImage("victoria.jpeg");
  victoria.resize(width, height);
  shader1  = loadShader("shader1.frag",  "shader1.vert");  // tex0, in1, in2, dispX, dispY
  shader2  = loadShader("shader2.frag",  "shader2.vert");  // tex0, in1, in2, dispX, dispY
  shader3  = loadShader("shader3.frag",  "shader3.vert");  // tex0, in1, in2, dispX, dispY
  shader4  = loadShader("shader4.frag",  "shader4.vert");  // tex0, in1, in2, textureWidth, textureHeight, dispX, dispY, amount
  lumaKey  = loadShader("lumaKey.frag",  "lumaKey.vert");  // tex0, th1, op1
  hueShift = loadShader("hueShift.frag", "hueShift.vert"); // tex0, hue, in2, 
  buffer1  = createGraphics(width, height, P2D);
  buffer2  = createGraphics(width, height, P2D);
  buffer3  = createGraphics(width, height, P2D);
  buffer4  = createGraphics(width, height, P2D);
  buffer5  = createGraphics(width, height, P2D);
  buffer6  = createGraphics(width, height, P2D);
}

void updateBuffers() {
  
  shader1.set("tex0", victoria);
  shader1.set("in1", 0.5);  // Set these to appropriate values
  shader1.set("in2", 0.5);  // Set these to appropriate values
  shader1.set("dispX", 0.0); // Set these to appropriate values
  shader1.set("dispY", 0.0); // Set these to appropriate values

  // buffer 1
  buffer1.beginDraw();
  buffer1.shader(shader1);
  buffer1.endDraw();
  
  shader2.set("tex0", buffer1);

  // buffer 2
  buffer2.beginDraw();
  buffer2.shader(shader2);
  buffer2.endDraw();
  
  shader3.set("tex0", buffer2);

  // buffer 3
  buffer3.beginDraw();
  buffer3.shader(shader3);
  buffer3.endDraw();
  
  shader4.set("tex0", buffer3);

  // buffer 4
  buffer4.beginDraw();
  buffer4.shader(shader4);
  buffer4.endDraw();
  
  lumaKey.set("tex0", buffer4);

  // lumaKey
  buffer5.beginDraw();
  buffer5.shader(lumaKey);
  buffer5.endDraw();
  
  hueShift.set("tex0", buffer5);

  // hueShift
  buffer6.beginDraw();
  buffer6.shader(hueShift);
  buffer6.endDraw();

}

void draw() {
  updateBuffers();
  image(buffer1, 0, 0);
}
