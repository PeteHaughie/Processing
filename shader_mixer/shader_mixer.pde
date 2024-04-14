PImage img1, img2, img3, img4;
PShader shader;

void setup() {
  size(720, 480, P2D); // Set the size of the window
  noLoop(); // No need to loop since we are not animating

  // Load images
  img1 = loadImage("image1.jpeg");
  img2 = loadImage("image2.jpeg");
  img3 = loadImage("image3.jpeg");
  img4 = loadImage("image4.jpeg");

  // Load the shader and set the texture uniforms
  shader = loadShader("mixer.glsl");
  shader.set("resolution", (float) width, (float) height);
  shader.set("tex0", img1);
  shader.set("tex1", img2);
  shader.set("tex2", img3);
  shader.set("tex3", img4);
}

void draw() {
  filter(shader);
}
