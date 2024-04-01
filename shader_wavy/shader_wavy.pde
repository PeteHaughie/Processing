PShader wavyShader;
PImage img;

void setup() {
  size(800, 600, P2D);
  // Load the shader from the file system
  wavyShader = loadShader("WavyEffect.frag");
  // Load an image to apply the effect to
  img = loadImage("01_simpleColorQuadExample.png");
}

void draw() {
  background(0);

  // Update shader uniforms
  wavyShader.set("time", millis() / 1000.0f);
  wavyShader.set("resolution", float(width), float(height));

  // Apply the shader
  shader(wavyShader);
  image(img, 0, 0, width, height);

  // Reset the shader for the rest of the drawing
  resetShader();
}
