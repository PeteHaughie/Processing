PShader shader;
PImage img;

PGraphics fbo;

float scale = 10.0;

void setup() {
  size(800, 800, P3D);
  
  // Load the image
  img = loadImage("victoria.png");
  
  // Load the shader files
  shader = loadShader("fragment_shader.glsl", "vertex_shader.glsl");
  // Pass the texture to the shader
  shader.set("u_texture", img);  // Set the uniform with the new name
  
  // Set the scale for depth
  shader.set("u_scale", scale);
  // draw the fbo
  fbo = createGraphics(800, 800, P3D);
  fbo.beginDraw();
  fbo.fill(0, 255, 255);
  // Apply the shader
//   fbo.shader(shader);
  fbo.beginShape(QUADS);
  fbo.textureMode(NORMAL);
  fbo.texture(img);
  int cols = fbo.width / 10;
  int rows = fbo.height / 10;
  fbo.translate(width / 2, height / 2);
  for (int y = 0; y < rows-1; y++) {
    for (int x = 0; x < cols-1; x++) {
      float x1 = map(x, 0, cols-1, -width/2, width/2);
      float y1 = map(y, 0, rows-1, -height/2, height/2);
      float u1 = (float)x / cols;
      float v1 = (float)y / rows;
      
      float x2 = map(x+1, 0, cols-1, -width/2, width/2);
      float y2 = y1;
      float u2 = (float)(x+1) / cols;
      float v2 = v1;
      
      float x3 = x2;
      float y3 = map(y+1, 0, rows-1, -height/2, height/2);
      float u3 = u2;
      float v3 = (float)(y+1) / rows;
      
      float x4 = x1;
      float y4 = y3;
      float u4 = u1;
      float v4 = v3;
      
      fbo.vertex(x1, y1, 0, u1, v1);
      fbo.vertex(x2, y2, 0, u2, v2);
      fbo.vertex(x3, y3, 0, u3, v3);
      fbo.vertex(x4, y4, 0, u4, v4);
    }
  }
  fbo.endShape();
  
  fbo.resetShader();
  fbo.endDraw();
}

void draw() {
  background(125, 0, 125);
  
  // Draw a plane with the shader applied
  translate(width / 4, 0, -100);
//   rotateX(PI/3);
//   rotateZ(PI/4);
  rotateY(PI/3);
  image(fbo, 0, 0, 800, 800);
}
